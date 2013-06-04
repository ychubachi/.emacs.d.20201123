# cloneするときのコマンド

```shell
$ cd ~
$ git clone git@github.com:ychubachi/.emacs.d.git
$ cd .emacs.d
$ git submodule init
$ git submolude update
```

# 新しくsubmoduleを追加するときの方法

```shell
git submodule add https://github.com/magit/magit.git git/magit
```

