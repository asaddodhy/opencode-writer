# Backup and Restore

## Two Required Artifacts

This project is restorable only when both artifacts are available:

| Artifact | Contains | Safe for GitHub? |
|---|---|---:|
| Git repository | Source code, Novel-OS workflows, OpenCode adapters, scripts, templates, documentation, and patches committed to Git | Yes |
| Backup tarball | Secrets, private data, databases, machine-level configuration, runtime state, and current local changes that are not safely represented by Git | No |

The Git repository alone cannot restore credentials, private writing data, databases, or exact machine state. The tarball alone cannot provide the maintained source history and reusable installation code. Restore requires both.

## Destination

The default destination is:

```text
/Volumes/Seagate_Backup_Plus_Drive/The Writer/
```

This is an SMB-mounted network drive. If it is unavailable, `scripts/backup.sh` writes to `~/Writer-backups/` and prints a prominent warning. A local fallback protects against accidental deletion but does not protect against loss of this Mac.

Override destinations when needed:

```bash
WRITER_BACKUP_DESTINATION="/Volumes/OtherDrive/The Writer" ./scripts/backup.sh
WRITER_BACKUP_FALLBACK="$HOME/Writer-backups" ./scripts/backup.sh
```

Archives use the sortable name:

```text
the-writer-backup-YYYYMMDD_HHMMSS.tar.gz
```

## What Is Discovered

`scripts/discover-paths.sh` runs every executable scanner under `scripts/scanners/`, then reads `99-custom-paths.txt`. Scanners emit existing paths only on stdout; diagnostics belong on stderr. Add new backup locations by adding a scanner or a path to `99-custom-paths.txt`, not by editing `backup.sh`.

The current scanners cover:

- Private application `.env`, database, and local project data
- Global OpenCode configuration and installed Novel-OS state
- User and system launch service directories when present
- The standalone Novel OS application's uncommitted Git changes, captured separately as a patch with its base commit

Reproducible dependency directories, caches, bytecode, and generated output are excluded from the application snapshot and can be rebuilt from the repository and lockfiles.

## Create a Backup

From the repository root:

```bash
./scripts/backup.sh
```

The command:

1. Discovers private and machine-specific paths.
2. Captures third-party worktree modifications using `git add -N`, `git diff --binary`, and the exact base commit.
3. Creates a timestamped gzip tarball on the network destination.
4. Falls back locally with a warning if the network destination fails.
5. Runs `gzip -t`, checks the archive entry count, and verifies critical metadata and patch files are present.

The script never prints secret contents. It may print path names and archive metadata.

## Restore on a New Machine

1. Install Git and the required runtime tools.
2. Clone the repository:

   ```bash
   git clone https://github.com/asaddodhy/the-writer.git
   cd the-writer
   ```

3. Connect or mount the network drive and locate the latest `the-writer-backup-*.tar.gz` archive.
4. Verify it before extraction:

   ```bash
   gzip -t /path/to/the-writer-backup-YYYYMMDD_HHMMSS.tar.gz
   tar -tzf /path/to/the-writer-backup-YYYYMMDD_HHMMSS.tar.gz | wc -l
   ```

5. Extract to a staging directory, never directly to `/` or the home directory. Archive paths contain the original absolute path with its username:

   ```bash
   mkdir -p "$HOME/restore-staging"
   tar -xzf /path/to/the-writer-backup-YYYYMMDD_HHMMSS.tar.gz -C "$HOME/restore-staging"
   ```

6. Review the extracted tree and copy only the intended paths into the new user's home directory. Replace the old username in paths with the new username; do not blindly copy an old `/Users/<name>` path.
7. Restore the repository and install the reusable layer:

   ```bash
   ./install.sh
   ```

8. Restore private files such as `.env` and databases from the staged archive, then tighten permissions:

   ```bash
   chmod 600 "$HOME/Documents/Writing/novel-os/.env"
   chmod 600 "$HOME/Documents/Writing/novel-os/novel_os.db"
   ```

9. Restore the captured local application patch only after checking its recorded base commit:

   ```bash
   cat "$HOME/restore-staging/payload/patches/novel-os-app/base-commit.txt"
   git -C /path/to/novel-os apply --check \
     "$HOME/restore-staging/payload/patches/novel-os-app/worktree.patch"
   git -C /path/to/novel-os apply \
     "$HOME/restore-staging/payload/patches/novel-os-app/worktree.patch"
   ```

10. Reinstall dependencies from the committed manifests. Do not restore `.venv`, `node_modules`, caches, or bytecode.
11. Recreate and verify services from restored definitions. Copying a launchd file is not enough:

   ```bash
   launchctl load "$HOME/Library/LaunchAgents/<label>.plist"
   launchctl list <label> | grep PID
   ```

   Confirm the process is running and inspect its logs before declaring the restore complete.

## Cadence and Staleness

Create a backup:

- Before operating-system upgrades or machine migrations
- After changing credentials, provider configuration, or service definitions
- After substantial writing sessions or database changes
- At least weekly while actively writing

Snapshots go stale. Databases, private project files, and runtime state change independently of Git. A months-old tarball can restore the application source while silently losing recent story data. Keep multiple dated archives and periodically test a restore on a separate location.

## Verification Limits

The backup script verifies gzip integrity, archive listing, entry count, and critical metadata/patch entries. It does not automatically prove that every secret is valid, that a database is logically healthy, or that launchd services start successfully on another machine. A real restore test is the final proof.
