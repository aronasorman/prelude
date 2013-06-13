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

;;; package configs

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

;;;;; evil mode
(package-verify 'evil)
(add-hook 'prog-mode-hook 'evil-local-mode)

;;;;; paredit mode
(package-verify 'paredit)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;;;; smartparens
(package-verify 'smartparens)
;;;;; ace jump mode
(package-verify 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "SPC") 'evil-ace-jump-word-mode)

;;;;; disable key chord
(package-verify 'key-chord)
(key-chord-mode -1)

;;;;; linum-relative
(package-verify 'linum-relative)
(global-linum-mode)
(linum-relative-toggle)

;;;;; ido vertical mode
(package-verify 'ido-vertical-mode)
(ido-vertical-mode 1)

;;;;; workgroups
(package-verify 'workgroups)
(setq wg-prefix-key (kbd "C-c C-w"))
(workgroups-mode 1)
(wg-load "~/.emacs.d/workgroups")
(define-key evil-normal-state-map (kbd "C-/") 'wg-switch-to-workgroup)
(global-set-key (kbd "C-/") 'wg-switch-to-workgroup)

;;;;; magit
(package-verify 'magit)

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

;;;;; projectile
(package-verify 'projectile)
(global-set-key (kbd "C-;") 'projectile-find-file)

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

(setq debug-on-error -1)
