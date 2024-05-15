#! /bin/bash
#
# sdboot-entrymanager script, auto updates kernel/initramfs in loaders/*.conf

BOOT_DIR="/boot"
EFI_DIR="/efi"

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Error: Root access is required to access ${EFI_DIR} partition."
        exit 1
    fi
}

create_entry() {
    # we should be able to create an entry with the tool
    # something like os-prober
    # will decide between single manual creation, auto creation of all, or a mix

    echo "unused"
}

update_entries() {
    # this will be the function that changes the *.conf files to reference the
    # most up-to-date kernel/ramdisk. (TODO figure out how exactly the symlinks are
    # updated on kernel upgrade for grub)

    # a terrible way of doing this would be slapping a cp -L command at the end of this
    # update process, apt edits symlink in boot, script writes file at symlink to
    # boot partition
    check_root

    cp -fL "${BOOT_DIR}/vmlinuz" "${EFI_DIR}/vmlinuz"
    cp -fL "${BOOT_DIR}/initrd.img" "${EFI_DIR}/initrd.img"
    echo "Kernel img and initrd copied from ${BOOT_DIR} to ${EFI_DIR}."
}

# in a perfect world I'll add functionality that to control the installation of sdboot itself

# TODO check `update-initramfs`

update_entries
