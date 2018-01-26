# nixos-configuration
Personal NixOs configuration

## Preparing the install media: USB Drive
Download the NixOS live CD from https://nixos.org. Use the `dd` utility to write the image verbatim to the drive: 
``` 
dd if=path-to-image of=/dev/sdb
```
Be careful about specifying the correct drive; you can use the `lsblk` command to get a list of block devices. If you're on macOS you can run `diskutil list` to see the list of devices; note that the device you'll use for the USB must be unmounted before writing the image (unmounting can be done within Disk Utility).

*(source: https://nixos.org/nixos/manual/index.html#sec-booting-from-usb)*

## Booting into the USB Drive
Press F12 during the boot sequence and choose the USB Drive: the NixOS installer should boot up. Autologin to root gives you immediate command-line access.

## Formatting the host disk *(source: https://chris-martin.org/2015/installing-nixos)*

![disklayout](https://github.com/jchapuis/nixos-configuration/raw/master/disklayout.png)

There are three partitions:

`/dev/sda1` is the BIOS boot partition. 
`/dev/sda2` will be mounted at /boot. This is unencrypted, because the boot process will need it  before we unlock the encrypted volume.
`/dev/sda3` is the encrypted partition.
The encrypted partition contains an LVM volume group called vg, which contains two logical volumes:

`/dev/vg/swap` will be used as swap space.
`/dev/vg/root` will be mounted at the root of the filesystem, /.

### Create the partitions
Run `fdisk -l` to show available disks, and select the destination one (we'll refer to it as `sdd`).

Use gdisk to create the partitions: `gdisk /dev/sdd`, and create a partition table that looks like this:

```
Number  Size        Code  Name
  1     1000.0 KiB  EF02  BIOS boot partition
  2     500.0 MiB   EF00  EFI System Partition
  3     <the rest>  8E00  Linux LVM
```

### Set up the encrypted LUKS volume
Initialize the encrypted partition:

`cryptsetup luksFormat /dev/sdd3`

Then open it:

`cryptsetup luksOpen /dev/sdd3 enc-pv`

### Create LVM group and volumes
This allocates 10G for swap, and the rest for the root volume.

```
pvcreate /dev/mapper/enc-pv
vgcreate vg /dev/mapper/enc-pv
lvcreate -n swap vg -L 10G
lvcreate -n root vg -l 100%FREE
```

### Format partitions
```
mkfs.vfat -n BOOT /dev/sda2
mkfs.ext4 -L root /dev/vg/root
mkswap -L swap /dev/vg/swap
```

## Installation
### Mount
Now mount all the disks and volumes you just created. The NixOS installer treats `/mnt` as the filesystem root for the installation. So instead of mounting to `/` and `/boot` as normally, for now we’re going to mount them to `/mnt` and `/mnt/boot` instead:

```
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/sdd2 /mnt/boot
```

### Configuration generation
Run this to generate config files:

```
nixos-generate-config --root /mnt
```

This creates two files in `/mnt/etc/nixos`:

`configuration.nix`, a default config file. (You’ll be making changes to this a lot).
`hardware-configuration.nix`, the results of a hardware scan (this is normally not to be edited, although as we'll see below we'll need to make a manual addition to this to support LUKS with an usb-keyboard).

### Fetching configuration 

Get the configuration from GitHub:

```
nix-shell -p git 
git clone https://github.com/jchapuis/nixos-configuration.git /mnt/etc/nixos 
exit
```

### Hardware configuration
Using full disk encryption with LUKS implies that we need to enter the password in Stage 1 of the bootsequence. Therefore, the ramdisk needs the proper modules to support usb keyboards. Here's the modification in `hardware-configuration.nix` that I had to manually do in order to get my Microsoft Natural Ergonomic keyboard to work:

```nix
 boot.initrd.kernelModules = [ "xhci_hcd" "xhci_pci" "ahci" "hid_microsoft" "dm_mod" "usbhid" "ata_generic" "ehci_pci" ];
```

### Installing

Install the system:

```
nixos-install
```

Reboot to the new system:

```
reboot
```