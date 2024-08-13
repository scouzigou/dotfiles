# dotfiles

### Manually deploy configuration

Using `stow`:

~~~bash
# see man stow
#stow --target=$HOME --dotfiles <package>
# Examples
stow --target=$HOME --dotfiles zsh
stow --target=$HOME --dotfiles gitconfig
stow --target=$HOME --dotfiles tmux
stow --target=$HOME --dotfiles neovim
...
~~~

> [!IMPORTANT]
> **Do not use `stow` on `./lightdm`.** It contains files that are used by `make install` only (see below)

### Automatic deployment with `make`

Look at `Makefile`:

~~~bash
make # this will print the different possibilities
~~~

### Tips

#### Configure keymap

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

#### Configure Dual boot with Windows

**Pre-requisite**: deploy UEFI version of Grub (when using USB key, boot from UEFI:my usb key)

1. locate the disk/partition containing Windows UEFI boot using `sudo fdisk -l`. Then, get the `uuid` of the partition using `sudo blkid` (field: `UUID`); example: `ABCD-1234`.

2. create a file in `/etc/grub.d/09_windows` with the following content:

  ~~~bash
#!/bin/sh
  exec tail -n +3 $0

  menuentry "Windows" --class windows --class os {
    insmod part_gpt
    search --no-floppy --set=root --fs-uuid abcd-1234
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
  }
  ~~~

3. make the file executable

~~~bash
sudo chmod +x /etc/grub.d/09_windows
~~~

4. make a copy of the current configuration

~~~bash
sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.backup
~~~

5. regenerate the configuration

~~~bash
sudo grub-mkconfig > /boot/grub/grub.cfg
~~~

**Note**: it is also possible to update the behavior of `Grub` by changing `/etc/default/grub`
