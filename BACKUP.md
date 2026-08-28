# Backup and Restore

## Three Required Artifacts

This project is restorable only when all three artifacts are available:

| Artifact | Contains | Storage safety |
|---|---|---|
| Git repository | Instructions, scripts, public configuration templates, source snapshots, and patches | Safe to push publicly; never contains secrets |
| Main tarball | Large files, private data, databases, readable machine-generated state, and service definitions | Unencrypted; assume anyone on the network can read it |
| Secrets container | Credentials, tokens, `.env` files, and other approved secret material | Encrypted with `age`; safe to store beside the main tarball |

None of the three is sufficient alone. The repository cannot restore private data or credentials. The main tarball cannot restore secrets. The encrypted secrets container cannot provide the source, scripts, or history.

Secrets never enter the main tarball.

## Current Locations

The default main-tarball destination is:

```text
/Volumes/Seagate_Backup_Plus_Drive/NAS/Local Repo Backup/The Writer/
```

The default secrets-container destination is the same directory. The drive is an SMB guest share, so the main tarball must be treated as readable by other devices on the LAN. The secrets container is encrypted before it is written to that destination.

The public `age` recipient is committed at:

```text
config/age-recipient.txt
```

The private `age` identity is not in Git and is not copied into either archive. Its recovery locations are:

1. Apple Passwords: entry named `Klip Apple notarization credentials`
2. Printed copy kept separately

The identity passphrase, if any, must be recovered from its separately managed secure location. It is not documented or stored in this repository.

## Create a Backup

From the repository root:

```bash
./scripts/backup.sh
```

The command:

1. Discovers approved non-secret paths using every executable scanner under `scripts/scanners/`.
2. Keeps `.env` out of that discovery stream.
3. Captures the standalone Novel OS application's uncommitted worktree changes using `git add -N`, `git diff --binary`, and its base commit.
4. Creates the unencrypted main tarball locally, then writes it to the network destination.
5. Creates the encrypted secrets container in local temporary staging and streams ciphertext to the destination using `age -r`.
6. Uses a prominent local fallback warning if the network destination is unavailable.
7. Verifies both archives, including a decrypt-and-list round-trip for the secrets container.

The script uses `umask 077` and removes local staging data on `EXIT`, `INT`, and `TERM`. It never prints secret contents.

Add paths by adding a new scanner under `scripts/scanners/` or a path to `99-custom-paths.txt`. Scanners emit paths only on stdout, skip absent paths, and send diagnostics to stderr.

## Restore on a New Machine

1. Install Git and `age`:

   ```bash
   brew install age
   ```

2. Clone the repository:

   ```bash
   git clone https://github.com/asaddodhy/the-writer.git
   cd the-writer
   ```

3. Retrieve the private `age` identity from Apple Passwords or the printed copy. Do not paste it into chat, Git, shell history, or a command-line argument.
4. Locate the matching main tarball and adjacent secrets container on the network drive.
5. Extract each artifact into a staging directory. Never extract directly into `$HOME` or `/`; archive paths contain the original username:

   ```bash
   mkdir -p "$HOME/restore-staging/main" "$HOME/restore-staging/secrets"
   tar -xzf /path/to/the-writer-backup-YYYYMMDD_HHMMSS.tar.gz \
     -C "$HOME/restore-staging/main"
   age -d -i /secure/path/identity.txt \
     /path/to/the-writer-secrets-YYYYMMDD_HHMMSS.tar.gz.age \
     | tar -xzf - -C "$HOME/restore-staging/secrets"
   ```

6. Review staged paths and copy them across manually, replacing the old username with the new one. Do not blindly copy old `/Users/<name>` paths.
7. Install reusable Novel-OS and OpenCode files:

   ```bash
   ./install.sh
   ```

8. Restore the private `.env` from the secrets staging directory and tighten permissions:

   ```bash
   chmod 600 "$HOME/Documents/Writing/novel-os/.env"
   ls -l "$HOME/Documents/Writing/novel-os/.env"
   ```

9. Restore the database and private project state from the main staging directory, then verify application-specific permissions.
10. Read the captured base commit:

    ```bash
    cat "$HOME/restore-staging/main/payload/patches/novel-os-app/base-commit.txt"
    ```

    Check out that commit in a clean clone of `mrigankad/Novel-OS`, then test and apply the patch:

    ```bash
    git -C /path/to/novel-os apply --check \
      "$HOME/restore-staging/main/payload/patches/novel-os-app/worktree.patch"
    git -C /path/to/novel-os apply \
      "$HOME/restore-staging/main/payload/patches/novel-os-app/worktree.patch"
    ```

11. Reinstall dependencies from committed manifests. Do not restore virtual environments, `node_modules`, caches, or bytecode.
12. Recreate service definitions from staged files and verify that services are running, not merely copied:

    ```bash
    launchctl load "$HOME/Library/LaunchAgents/<label>.plist"
    launchctl list <label> | grep PID
    ```

If a secret was ever extracted to a shared or incorrect location during a failed restore, treat it as exposed and rotate it.

## Verification and Limits

The backup script verifies:

- Main archive gzip integrity
- Main archive entry count
- Main archive critical metadata and configuration paths
- No secret-like filenames in the main archive
- Encrypted archive decryption using the configured identity
- Encrypted archive tar listing and expected `.env` entry
- Captured patch and base commit presence

A temporary restore rehearsal has also been performed for the current archive. It extracted metadata, private files, database, and the worktree patch into temporary staging without overwriting live state.

The process does not prove that credentials remain valid, that the database is logically healthy, that every private key's passphrase works, or that launchd services will start on a different machine. The `age` identity was verified by deriving the public recipient from the actual local identity file. The identity's Apple Passwords and printed recovery copies were not independently inspected by this process.

## Cadence and Staleness

Create a backup:

- Before operating-system upgrades or machine migrations
- After changing credentials, provider configuration, or service definitions
- After substantial writing sessions or database changes
- At least weekly while actively writing

Snapshots go stale. Credentials rotate, databases grow, and private project data changes independently of Git. Keep multiple dated archives and periodically perform a real restore using the identity retrieved from Apple Passwords, not merely a local copy.

Older archives created before the encrypted-container change may contain plaintext secrets. They are not compliant with this policy and have not been deleted automatically.
