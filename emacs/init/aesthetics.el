;;; Font Configuration
(set-font "SF Mono" 18)
(set-cursor-color "#C199FE")
(setq default-text-properties '(line-spacing 0.25 line-height 1.25))
(setq-default tab-width 2)

;;; Theme Configuration
(use-package doom-themes
  :straight t
  :config
  (set-themes '(doom-gruvbox doom-gruvbox-light))
  (doom-themes-treemacs-config))

;;; UI Enhancements
(use-package nerd-icons
  :straight t
  :config
  (unless (member "Symbols Nerd Font Mono" (font-family-list))
    (nerd-icons-install-fonts t)))

(use-package all-the-icons
  :straight t
  :config
  (unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t)))

(use-package doom-modeline
  :straight t
  :config
  (doom-modeline-mode 1))

(use-package anzu
  :straight t
  :config
  (global-anzu-mode 1))

;;; Custom File Management
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
