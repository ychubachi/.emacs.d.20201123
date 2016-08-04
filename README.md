# What is this?

This is my init for Emacs.

# Key binding

- Use C-c d.

# How to use

```shell
$ cd ~
$ git clone git@github.com:ychubachi/.emacs.d.git
$ cd .emacs.d
$ git submodule init
$ git submolude update
```

# How to add git module

```shell
git submodule add https://github.com/magit/magit.git git/magit
```

# For debug,

```
/usr/local/bin/emacs -q -l init.el --debug-init
```
