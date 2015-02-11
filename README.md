* What is this?

This is my init for Emacs.

For debug,

```
/usr/local/bin/emacs -q -l init.el --debug-init
```

* Keybind

```
grep -nH -e global-set-key *
00-keybind.el:3:(global-set-key (kbd "C-c ?") 'help-command)
00-keybind.el:4:(global-set-key (kbd "C-z") 'shell)
10-flymake.el:3:(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
10-flymake.el:4:(global-set-key [f4] 'flymake-goto-next-error)
10-fullscreen.el:6:(global-set-key [f11] 'fullscreen)
30-buffer-move.el:8:(global-set-key (kbd "<C-S-up>")     'buf-move-up)
30-buffer-move.el:9:(global-set-key (kbd "<C-S-down>")   'buf-move-down)
30-buffer-move.el:10:(global-set-key (kbd "<C-S-left>")   'buf-move-left)
30-buffer-move.el:11:(global-set-key (kbd "<C-S-right>")  'buf-move-right)
30-goto-last-change.el:9:(global-set-key (kbd "C-x C-/") 'goto-last-change)
30-helm.el:9:(global-set-key (kbd "C-c h") 'helm-mini)
30-helm.el:10:(global-set-key (kbd "C-x C-f") 'helm-find-files)
30-ido.el_:26:(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
30-ido.el_:27:;; (global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
30-ido.el_:28:(global-set-key (kbd "C-x B") 'ibuffer)
30-ido.el_:35:(global-set-key (kbd "M-x") 'smex)
30-ido.el_:36:(global-set-key (kbd "M-X") 'smex-major-mode-commands)
30-magit.el:10:(global-set-key (kbd "C-x v") 'magit-status)
30-redo+.el:9:(global-set-key (kbd "C-,") 'redo)
30-redo+.el:12:(global-set-key (kbd "C-.") 'undo)
linux-ibus.el:24:(global-set-key [henkan] 'ibus-enable)
linux-ibus.el:26:(global-set-key [muhenkan] 'ibus-disable)
```

```
grep -nH -e define-key *
10-wdired.el:3:(define-key dired-mode-map "r"
30-auto-complete.el:9:(define-key ac-complete-mode-map "\C-n" 'ac-next)
30-auto-complete.el:10:(define-key ac-complete-mode-map "\C-p" 'ac-previous)
30-haml-mode.el:14:		 (define-key haml-mode-map "\C-m" 'newline-and-indent)))
30-ido.el_:18:; (define-key ido-mode-map (kbd "C-p") 'ido-prev-match) うまくいかない
30-ido.el_:19:; (define-key ido-mode-map (kbd "C-n") 'ido-next-match)
30-scss-mode.el:14:		 (define-key haml-mode-map "\C-m" 'newline-and-indent)))
30-shell.el:13:		 (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
30-shell.el:15:		 (define-key term-raw-map (kbd "C-y") 'term-paste)
30-shell.el:17:		 (define-key term-raw-map (kbd "C-c C-p") 'term-send-up)
30-shell.el:19:		 (define-key term-raw-map (kbd "C-c C-n") 'term-send-down)
30-shell.el:22:		 (define-key term-raw-map  (kbd "C-'") 'term-line-mode)
30-shell.el:23:		 (define-key term-mode-map (kbd "C-'") 'term-char-mode)
30-shell.el:26:		 (define-key term-raw-map  (kbd "C-y") 'term-paste)
50-ruby-rcodetools.el:7:(define-key ruby-mode-map (kbd "<C-return>") 'rct-complete-symbol)
50-yatex.el:79:             (define-key YaTeX-mode-map (kbd "C-c e") 'evince-forward-search)))
```


* cloneするときのコマンド

```shell
$ cd ~
$ git clone git@github.com:ychubachi/.emacs.d.git
$ cd .emacs.d
$ git submodule init
$ git submolude update
```

* 新しくsubmoduleを追加するときの方法

package.elで追加できないものを追加するときは，gitでcloneします．

```shell
git submodule add https://github.com/magit/magit.git git/magit
```
