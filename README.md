# dotfiles

This repository contains my **personal** *stuff* to setup my configuration => do not use as it is...

## Stow configuration files

With [`stow`](https://archlinux.org/packages/extra/any/stow/):

~~~bash
# See man stow (--target is not really necessary when .dotfiles folder is in HOME folder)
# Examples
stow --target=$HOME --dotfiles zsh
stow --target=$HOME --dotfiles gitconfig
stow --target=$HOME --dotfiles tmux
stow --target=$HOME --dotfiles neovim
...
~~~

> [!IMPORTANT]
> **Do not use `stow` on `./lightdm`.** It contains files that are used by `make install` only (see below)

## Install with `make install`

Look at the `Makefile`:

~~~bash
make # this will print the different possibilities
~~~

## Personal notes

### Configure keymap

~~~bash
# VC Keymap = us
sudo localectl --no-convert set-keymap us
# X11 two variant us and us international (toggle with ctrl+alt)
sudo localectl --no-convert set-x11-keymap us,us,fr pc105,pc105,pc105 "",intl,"" grp:ctrl_shift_toggle
# check
localectl
~~~

Interesting resources:

- <https://wiki.archlinux.org/title/Xorg/Keyboard_configuration>
- `man xkeyboard-config`
- `base.lst` file located in `/usr/share/X11/xkb/rules/`

### Configure Dual boot with Windows

**Pre-requisite**: deploy UEFI version of Grub (when using USB key, boot from UEFI:my usb key)

- locate the disk/partition containing the Windows UEFI boot:

  ~~~bash
  sudo fdisk -l
  ~~~

- find the `uuid` of disk/partition found in the previous step:

  ~~~bash
  # look at the field UUID
  sudo blkid
  ~~~

- create the file `/etc/grub.d/09_windows`:

  ~~~bash

  #!/bin/sh

  exec tail -n +3 $0

  menuentry "Windows" --class windows --class os {
    insmod part_gpt
    search --no-floppy --set=root --fs-uuid <UUID>
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
  }
  ~~~

> [!IMPORTANT]
> do not forget to replace `<UUID>` with the value found in the previous step

- make the file executable:

  ~~~bash
  sudo chmod +x /etc/grub.d/09_windows
  ~~~

- make a copy of the current configuration of Grub:

  ~~~bash
  sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.original
  ~~~

- regenerate the configuration of Grub:

  ~~~bash
  sudo sh -c 'grub-mkconfig > /boot/grub/grub.cfg'
  ~~~

**Note**: it is also possible to update the behavior of `Grub` by changing `/etc/default/grub`
