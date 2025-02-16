;;; Basic Editor Settings
(setq-default indent-tabs-mode nil            ; Use spaces instead of tabs
              tab-width 2                     ; Set tab width to 2 spaces
              fill-column 100)                ; Set max line length
(setq sentence-end-double-space nil)          ; No double space after periods

;; Enable auto-fill and visual line modes
(auto-fill-mode 1)
(global-visual-line-mode 1)

;;; File Cleanup Hooks
(add-hook 'before-save-hook
          (lambda ()
            (unless (derived-mode-p 'markdown-mode)
              (delete-trailing-whitespace))))

;;; Core Editing Packages
(use-package with-editor
  :straight t
  :config
  (add-hook 'with-editor-mode-hook 'evil-insert-state))

(use-package hippie-exp
  :general
  (:states 'insert
   "M-<tab>" 'hippie-expand))

(use-package evil-nerd-commenter
  :straight t
  :after evil
  :general
  (:states '(normal visual)
   ", c i" 'evilnc-comment-or-uncomment-lines))

;;; Parentheses Management
(use-package parinfer
  :straight t
  :general
  (:keymaps 'parinfer-mode-map
   :states  'insert
   "<tab>"     'parinfer-smart-tab:dwim-right
   "<backtab>" 'parinfer-smart-tab:dwim-left)
  :config
  (setq parinfer-extensions '(defaults pretty-parens smart-yank evil))
  (advice-add 'evilnc-comment-or-uncomment-lines
              :after (lambda (_)
                       (when (bound-and-true-p parinfer-mode)
                         (parinfer-indent-buffer)))))

;;; Column Management
(use-package column-enforce-mode
  :straight t
  :hook prog-mode
  :general
  (:states '(normal)
   "s-<up>"    'column-enforce-mode
   "s-<down>"  'default-max-column-width
   "s-<right>" 'increase-max-column-width
   "s-<left>"  'decrease-max-column-width)
  :init
  (defvar column-enforce-column-default 100)
  (defvar column-enforce-column column-enforce-column-default)
  :config
  (defun set-max-column-width (width)
    (setq column-enforce-column width)
    (column-enforce-mode 1)
    (message "Max column width: %d" width))

  (defun default-max-column-width ()
    (interactive)
    (set-max-column-width column-enforce-column-default))

  (defun increase-max-column-width ()
    (interactive)
    (set-max-column-width (+ column-enforce-column 10)))

  (defun decrease-max-column-width ()
    (interactive)
    (set-max-column-width (- column-enforce-column 10))))
