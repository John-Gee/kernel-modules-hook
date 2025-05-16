#!/bin/dash
#
# cleanup-old-modules.sh  — remove out‑of‑tree / old DKMS modules for a given kernel
#
# usage: cleanup-old-modules.sh <kernel-version>

KVER=$1
oldmoddir=/usr/lib/modules/.old
dkms_backup_dir=/usr/lib/modules/dkms-backup

echo "[cleanup] starting; target kernel = $KVER"

# 1) move any /usr/lib/modules/<ver> that
#    • isn’t the current kernel (KVER)
#    • and isn’t owned by pacman
mkdir -p "$oldmoddir"
echo "[cleanup] ensuring .old dir exists at $oldmoddir"

for moddir in /usr/lib/modules/[0-9]*; do
  ver=${moddir##*/}
  if [ "$ver" = "$KVER" ]; then
    echo "[skip] keeping current kernel modules: $ver"
    continue
  fi

  if pacman -Qo "$moddir" >/dev/null 2>&1; then
    echo "[skip] pacman-owned modules: $ver"
    continue
  fi

  echo "[move] $moddir → $oldmoddir/"
  mv -- "$moddir" "$oldmoddir/"
done

# 2) for each DKMS backup sub‑dir, 
#    remove that module/version for KVER
if [ -d "$dkms_backup_dir" ]; then
  echo "[dkms] scanning backups in $dkms_backup_dir"
  for module_dir in "$dkms_backup_dir"/*; do
    [ -d "$module_dir" ] || continue
    module_name=${module_dir##*/}

    module_version=$(ls "$module_dir" 2>/dev/null \
      | grep -E '^[0-9]+\.[0-9]+\.[0-9]+' \
      | head -n1)
    if [ -z "$module_version" ]; then
      echo "[dkms skip] no version found for $module_name"
      continue
    fi

    echo "[dkms remove] module=$module_name version=$module_version kernel=$KVER"
    dkms remove -m "$module_name" -v "$module_version" -k "$KVER" || \
      echo "[dkms error] failed to remove $module_name/$module_version"
  done
else
  echo "[dkms] no backup directory at $dkms_backup_dir"
fi

echo "[cleanup] done."
