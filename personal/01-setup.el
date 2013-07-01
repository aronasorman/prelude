(setq debug-on-error 1)

;;; variables

;;; emacs builtin custom settings

;;;;; removing annoyances in the GUI
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;;;;; builtin mode config
(global-hl-line-mode 1)

;;;;;;; remove whitespace in each save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; package configs

;;;;; theme
(load-theme 'solarized-dark)

;;;;; some useful functions
(defun package-verify (package-name)
  (unless (package-installed-p package-name)
    (package-install package-name))
  (require package-name))

;;;;; windmove
(global-set-key (kbd "C-M-l") 'windmove-right)
(global-set-key (kbd "C-M-h") 'windmove-left)
(global-set-key (kbd "C-M-j") 'windmove-down)
(global-set-key (kbd "C-M-k") 'windmove-up)

;;;;; dired mode
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))

;;;;; auto complete
(package-verify 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;;;;; eldoc mode
(add-hook 'prog-mode-hook 'eldoc-mode)

;;;;; keyfreq - look at which commands are used most often
(package-verify 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;;;;; evil mode
(package-verify 'evil)
(add-hook 'prog-mode-hook 'evil-local-mode)

;;;;; paredit mode
(package-verify 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;;;; smartparens
(package-verify 'smartparens)
(add-hook 'prog-mode-hook (lambda ()
                            (smartparens-mode 1)
                            (electric-pair-mode -1)))
;;;;; ace jump mode
(package-verify 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "SPC") 'evil-ace-jump-word-mode)

;;;;; disable key chord
(package-verify 'key-chord)
(key-chord-mode -1)

;;;;; linum-relative
(package-verify 'linum-relative)
(global-linum-mode)
;; (linum-relative-toggle)

;;;;; elixir-mode
(package-verify 'elixir-mode)

;;;;; ido vertical mode
(package-verify 'ido-vertical-mode)
(ido-vertical-mode 1)

;;;;; slime -- the superior lisp interaction mode for emacs!
(package-verify 'slime)
(setq inferior-lisp-program "sbcl")
(setq slime-compile-file-options '(:fasl-directory "/tmp/slime-fasls/"))
(slime-setup '(slime-repl))

;;;;; workgroups
(package-verify 'workgroups)
(setq wg-prefix-key (kbd "C-c C-w"))
(workgroups-mode 1)
(wg-load "~/.emacs.d/workgroups")
(define-key evil-normal-state-map (kbd "C-/") 'wg-switch-to-workgroup)
(global-set-key (kbd "C-/") 'wg-switch-to-workgroup)

;;;;; magit
(package-verify 'magit)
(global-set-key (kbd "<f11>") 'magit-status)

;;;;;;; fullscreen magit
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

;;;;; python mode -- builtin to emacs since 24.2
(require 'python)
(fset 'insert-pdb-breaktpoint-above-line
   [?O ?i ?m ?p ?o ?r ?t ?  ?p ?d ?b ?\; ?  ?p ?d ?b ?. ?s ?e ?t ?_ ?t ?r ?a ?c ?e ?\( ?\) escape])
(define-key python-mode-map (kbd "C-c C-o") 'insert-pdb-breaktpoint-above-line)

;;;;; jedi -- autocompletion for python
;; (package-verify 'jedi)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:setup-keys 1)
;; (setq jedi:complete-on-dot 1)

;;;;; imenu
(global-set-key (kbd "M-i") 'imenu)

;;;;; projectile
(package-verify 'projectile)
(setq projectile-enable-caching -1)
(global-set-key (kbd "C-;") 'projectile-find-file)

;;;;; haskell mode
(package-verify 'haskell-mode)
(require 'haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

;;;;; go mode
(package-verify 'go-mode)

;;;;; flx -- sublime text matching for emacs! Slow for now
(package-verify 'flx)
;; (flx-ido-mode 1)
;; (setq gc-cons-threshold 20000000)

;;; miscellaneous keybindings
(global-set-key (kbd "C-c C-c") 'eval-defun)
(global-set-key (kbd "RET") 'newline-and-indent)

;;;;; for closing windows
(global-set-key (kbd "C-\\") 'delete-other-windows)
(global-set-key (kbd "M-\\") 'delete-window)

;;;;; creating new windows
(global-set-key (kbd "C-c |") 'split-window-right)
(global-set-key (kbd "C-c -") 'split-window-below)

;;;;; for joining lines
(global-set-key (kbd "M-j") (lambda ()
                              (interactive)
                              (join-line -1)))

;;;;; correct some keybindings from evil
(define-key evil-normal-state-map (kbd "TAB") 'evil-indent-line)


(setq debug-on-error nil)
