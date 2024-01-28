;; Initialize

(load "~/.dotfiles/emacs/bootstrap")
(load "~/.dotfiles/emacs/features")
(load "~/.dotfiles/emacs/functions")


;; Aesthetics

(set-font "SF Mono" 18)
(set-cursor-color "#C199FE")

(setq default-text-properties '(line-spacing 0.25 line-height 1.25))
(setq-default tab-width 2)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package all-the-icons
  :straight t) ;; Run `all-the-icons-install-fonts` manually

(use-package doom-themes
  :straight t
  :config
  (set-themes '(doom-moonlight doom-nord-light))
                ;; doom-flatwhite
                ;; doom-shades-of-purple
                ;; doom-one-light
                ;; doom-city-lights-light
                ;; doom-dracula-light
                ;; doom-flatwhite-light
                ;; doom-gruvbox-light
                ;; doom-henna-light
                ;; doom-icy-light
                ;; doom-material-light
                ;; doom-miramare
                ;; doom-opera-light
                ;; doom-plain-light
                ;; doom-solarized-light
                ;; doom-tomorrow-day)
  (doom-themes-treemacs-config))

(use-package doom-modeline
  :straight t
  :config   (doom-modeline-mode 1))

(use-package anzu
  :straight t
  :config   (global-anzu-mode 1))


;; Editing

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default fill-column 100)
(setq sentence-end-double-space nil)

(auto-fill-mode 1)
(global-visual-line-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package column-enforce-mode
  :straight t
  :hook     prog-mode
  :general
  (:states     '(normal)
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

(use-package with-editor
  :straight t
  :config   (add-hook 'with-editor-mode-hook 'evil-insert-state))

(use-package hippie-exp
  :general
  (:states   'insert
   "M-<tab>" 'hippie-expand))

(use-package yasnippet
  :straight t
  :config
  (add-to-list 'load-path "~/.dotfiles/emacs/snippets")
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t)

(use-package evil-nerd-commenter
  :straight t
  :after    evil
  :general
  (:states  '(normal visual)
   ", c i"  'evilnc-comment-or-uncomment-lines))

(use-package flycheck
  :straight t
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (global-flycheck-mode 0))

(use-package company
  :straight   t
  :general
  (:keymaps   'company-active-map
   "C-j"      'company-select-next-or-abort
   "C-k"      'company-select-previous-or-abort
   "<escape>" 'company-abort)
  :init       (add-hook 'after-init-hook 'global-company-mode))

(use-package diff-hl
  :straight t
  :config
  (global-diff-hl-mode 1)
  (diff-hl-margin-mode 1)
  (setq diff-hl-margin-symbols-alist '((insert . "▍") (delete . "▍") (change . "▍") (unknown . "▍") (ignored . "▍")))
  (set-face-attribute 'diff-hl-margin-insert nil :foreground "#9fbd70" :inherit nil)
  (set-face-attribute 'diff-hl-margin-delete nil :foreground "#ee756f" :inherit nil)
  (set-face-attribute 'diff-hl-margin-change nil :foreground "#e5c084" :inherit nil))

(use-package parinfer
  :straight    t
  :general
  (:keymaps    'parinfer-mode-map
   :states     'insert
   "<tab>"     'parinfer-smart-tab:dwim-right
   "<backtab>" 'parinfer-smart-tab:dwim-left)
  :config
  (setq parinfer-extensions '(defaults pretty-parens smart-yank evil))
  (advice-add 'evilnc-comment-or-uncomment-lines
              :after (lambda (_)
                       (when (bound-and-true-p parinfer-mode)
                         (parinfer-indent-buffer)))))


;; Keybindings

(which-key-add-key-based-replacements
  "§ f" "find"
  "§ q" "quit")

(general-define-key
  "s-q"   nil
  "§ q q" 'delete-frame
  "§ q k" 'kill-emacs
  "§ q r" 'restart-emacs
  "§ n"   'remember-notes
  "§ t"   'cycle-themes
  "§ l"   'cycle-language
  "§ L"   'flyspell-buffer
  "s-B"   'previous-buffer
  "s-k"   'kill-this-buffer-unless-scratch
  "s-K"   'kill-other-buffers
  "s-="   'increase-font
  "s--"   'decrease-font
  "s-0"   'reset-font
  "s-§"   'other-window
  "M-§"   'other-window
  "s-w"   'delete-window
  "M-f"   'delete-other-windows)

(general-define-key
  :keymaps  '(global-map help-mode-map)
  "M-<tab>" 'evil-window-next)

(general-define-key
  :keymaps '(evil-normal-state-map)
  "Q" 'kmacro-end-and-call-macro)


;; Navigation

(use-package evil
  :straight t
  :general
  (:states  'normal
   "U"      'undo-redo)
  (:states  'visual
   ">"      'evil-shift-right-visual
   "<"      'evil-shift-left-visual
   "+"      'align-by-equals-symbol)
  (:states  'insert
   "M-§"    'insert-paragraph-symbol
   "M-2"    'insert-euro-symbol)
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :straight t
  :config
  (evil-collection-init))

(use-package projectile
  :straight t
  :after    evil
  :general
  (:states  'normal
   "!"      'projectile-run-async-shell-command-in-root
   "s-r"    'projectile-replace)
  :init     (projectile-mode 1))

(use-package helm
  :straight        t
  :after           evil
  :general
  ("M-x"           'helm-M-x
   "s-b"           'helm-buffers-list
   "s-<backspace>" 'helm-resume
   "§ f f"         'helm-find-files)
  (:keymaps        'evil-normal-state-map
   "_"             'helm-M-x)
  (:keymaps        'evil-visual-state-map
   "_"             'helm-M-x)
  (:keymaps        'helm-map
   "C-f"           'helm-next-page
   "C-b"           'helm-previous-page
   "C-h"           'backward-char
   "C-l"           'forward-char
   "M-h"           'backward-word
   "M-l"           'forward-word
   "C-j"           'helm-next-line
   "C-k"           'helm-previous-line
   "<tab>"         'helm-execute-persistent-action
   "<escape>"      'helm-keyboard-quit)
  :config
  (helm-mode 1)
  (setq helm-always-two-windows nil)
  (setq helm-display-buffer-default-height 25)
  (setq helm-default-display-buffer-functions '(display-buffer-in-side-window)))

(use-package helm-ag :straight t)

(use-package helm-projectile
  :straight t
  :general
  ("s-F"    'helm-projectile-ag
   "s-f"    'helm-projectile-find-file
   "s-p"    'helm-projectile-switch-project)
  :config   (helm-projectile-on))

(use-package treemacs
  :straight   t
  :general
  (:keymaps   'global-map
   :states    'normal
   "T o"      'treemacs-add-and-display-current-project)
  (:keymaps   'treemacs-mode-map
   "<escape>" 'treemacs-quit
   "D"        'treemacs-remove-project-from-workspace
   "c d"      'treemacs-create-dir
   "c f"      'treemacs-create-file
   "m"        'treemacs-move-file
   "r"        'treemacs-rename-file
   "d"        'treemacs-delete-file
   "o"        'treemacs-RET-action))

(use-package treemacs-evil :straight t)
(use-package treemacs-projectile :straight t)
(use-package treemacs-magit :straight t)


;; Window Management

(use-package popwin
  :straight t
  :general
  (:states  'normal
   "M-k"    'popwin:close-popup-window
   "M-b"    'popwin:popup-last-buffer)
  :config
  (push '("*shell*" :height 20 :position bottom :stick t) popwin:special-display-config)
  (push '("*Async Shell Command*" :height 20 :position bottom :stick t) popwin:special-display-config)
  (push '(minitest-compilation-mode :width 0.5 :position right :noselect t :stick t) popwin:special-display-config)
  (message "loaded window management")
  :init
  (popwin-mode 1))


;; Shell

(use-package shell
  :general
  (:states  'normal
   "-"      'project-shell)
  (:keymaps 'shell-mode-map
   :states  'normal
   "s-k"    'kill-this-buffer)
  (:keymaps 'shell-mode-map
   :states  '(normal insert)
   "C-k"    'comint-previous-input
   "C-j"    'comint-next-input))


;; Magit

(use-package magit
  :straight   t
  :general
  (:states    'normal
   "+"        'magit-status)
  (:keymaps   '(magit-status-mode-map magit-diff-mode-map magit-process-mode-map magit-log-mode-map)
   "<escape>" 'magit-mode-bury-buffer
   "$"        'magit-process-buffer))

;; Remember Notes
(setq remember-data-file "~/Documents/Notes/emacs")
(setq initial-buffer-choice 'remember-notes)
(add-hook 'emacs-startup-hook (lambda () (when (string= (buffer-name) "*notes*") (markdown-mode))))
(advice-add 'remember-notes :after (lambda (&rest _) (markdown-mode)))

;; Markdown

(use-package markdown-mode :straight t)


;; YAML

(use-package yaml-mode :straight t)


;; JSON

(use-package json-mode :straight t)


;; Docker

(use-package dockerfile-mode :straight t)


;; ELisp

(use-package elisp-mode :config (add-hook 'emacs-lisp-mode-hook 'parinfer-mode))


;; Web (HTML/CSS/JS)

(general-define-key
 :keymaps '(mhtml-mode-map)
 "§" nil)

(use-package emmet-mode
  :straight t
  :general
  (:states   'insert
   "C-<tab>" 'emmet-expand-line)
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode))

(use-package web-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.sass\\'" . web-mode))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(use-package js2-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-basic-offset 2))


;; Ruby

(use-package enh-ruby-mode
  :straight t
  :init
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
  :general
  (:states 'normal
           "<tab>" 'hs-toggle-hiding
           "C-<tab>" 'enh-ruby-next-method)
  :config
  (add-hook 'enh-ruby-mode-hook
            (lambda ()
              (setq hs-special-modes-alist
                    (cons '(enh-ruby-mode
                            "\\(def\\|do\\|{\\)" "\\(end\\|}\\)" "#"
                            (lambda (arg) (ruby-end-of-block)) nil)
                          hs-special-modes-alist))
              (hs-minor-mode t)))) ; Enable hide-show

(defun enh-ruby-next-method ()
  "Move point to the beginning of the next method in enh-ruby-mode."
  (interactive)
  (when (looking-at "\\s-*def")
    (end-of-line))
  (ruby-beginning-of-defun -1)
  (when (eobp)
    (goto-char (point-min))
    (ruby-beginning-of-defun -1)))

(defun enh-ruby-next-method ()
  "Move point to the beginning of the next method in enh-ruby-mode."
  (interactive)
  (when (looking-at "\\s-*def")
    (end-of-line))
  (unless (re-search-forward "\\s-*def" nil t)
    (goto-char (point-min))
    (re-search-forward "\\s-*def" nil t))
  (beginning-of-line))


(use-package inf-ruby
  :straight t
  :config
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
  (defun inf-ruby-console-rails-from-project-root ()
    (interactive)
    (inf-ruby-console-rails (projectile-project-root)))
  :general
  (:states 'normal
           ", i i" 'inf-ruby
           ", i r" 'inf-ruby-console-rails-from-project-root
           ", i s" 'ruby-switch-to-inf))

(use-package robe
  :straight t
  :config
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  (eval-after-load 'company '(push 'company-robe company-backends))
  :general
  (:states 'normal
           "s-<return>" 'robe-jump))

(use-package chruby
  :straight t
  :config   (add-hook 'enh-ruby-mode-hook 'chruby-use-corresponding))

(use-package minitest
  :straight t
  :general
  (:keymaps 'enh-ruby-mode-map
   :states  'normal
   ", t t"  'minitest-verify-single
   ", t f"  'minitest-verify
   ", t a"  'minitest-verify-all
   ", t c"  'simplecov-open)
  :config
  (add-hook 'minitest-compilation-mode-hook
    (lambda ()
      (local-set-key (kbd "g g") 'evil-goto-first-line))))


;; Python
;; Configure Python for 4 spaces instead of tabs
;; Python Configuration
;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set default tab width to 4 spaces
(setq-default tab-width 4)

;; Set python-indent-offset to 4 spaces
(setq python-indent-offset 4)

;; Enable electric-indent-mode
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq python-indent-offset 4)))

;; Crystal

(use-package crystal-mode :straight t)


;; Clojure

(use-package clojure-mode
  :straight t
  :config
  (setq clojure-indent-style 'align-arguments)
  (setq clojure-align-forms-automatically t)
  (add-hook 'clojure-mode-hook 'parinfer-mode))

(use-package cider
  :straight t
  :general
  (:keymaps 'clojure-mode-map
   :states 'normal
   ", r j" 'cider-jack-in-clj
   ", r c" 'cider-connect-clj)
  (:keymaps 'clojurescript-mode-map
   :states 'normal
   ", c j" 'cider-jack-in-cljs
   ", c c" 'cider-connect-cljs)
  :init
  (add-to-list 'safe-local-variable-values '(cider-default-cljs-repl . shadow))
  (add-to-list 'safe-local-variable-values '(cider-shadow-default-options . "app"))
  :config
  (setq cider-enhanced-cljs-completion-p nil))


;; Go

(use-package go-mode
  :straight t
  :config   (add-hook 'before-save-hook 'gofmt-before-save))


;; Rust

(use-package rust-mode
  :straight t
  :general
  (:keymaps 'rust-mode-map
   :states  'normal
   ", r"    'rust-run
   ", t"    'rust-test
   ", b"    'rust-compile)
  :config   (setq rust-format-on-save t))


;; TypeScript

(use-package typescript-mode :straight t)

(use-package tide
  :straight t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :config
  (setq-default typescript-indent-level 2))


;; Copilot

(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'copilot-mode)
  (add-hook 'after-init-hook 'global-copilot-mode)
  :general
  (:states 'insert
   "s-/" 'copilot-next-completion
   "s-<return>" 'copilot-accept-completion
   "s-c" 'copilot-mode)
  (:states 'normal
   "s-/" 'copilot-mode))

;; chatgpt-shell + custom prompts

(use-package shell-maker
  :straight (:host github :repo "xenodium/chatgpt-shell" :files ("shell-maker.el")))

(use-package chatgpt-shell
  :requires shell-maker
  :straight (:host github :repo "xenodium/chatgpt-shell" :files ("chatgpt-shell.el"))
  :config
  (setq chatgpt-shell-transmitted-context-length 1)
  (setq chatgpt-shell-context-tokens 8192)
  :bind
  (:map global-map
        ("M-s" . chatgpt-shell)
        ("M-i" . chatgpt-shell-interrupt)
        ("M-m" . chatgpt-shell-write-commit-message))
  (:map evil-visual-state-map
        ("M-a" . chatgpt-shell-prompt)
        ("M-p" . chatgpt-shell-proofread-region)
        ("M-r" . chatgpt-shell-refactor-code)
        ("M-c" . chatgpt-shell-comment-code)
        ("M-d" . chatgpt-shell-describe-code)
        ("M-e" . chatgpt-shell-explain-code)))

(defvar my-openai-key-cache nil)

(defun get-openai-key-from-1password ()
  "Retrieves an OpenAI API key from 1Password. Caches the key for subsequent access."
  (or my-openai-key-cache
      (setq my-openai-key-cache
            (string-trim-right (shell-command-to-string
                                "op read op://Shared/ChatGPT/api-key")))))

(setq chatgpt-shell-openai-key 'get-openai-key-from-1password)

(defcustom chatgpt-shell-prompt-header-comment-code
  "Write a comment for the code below. Trim the actual code to only
include the comment. Keep the comment concise. Don't start the
sentence with any variant of 'Defines a function that...'"
  "Prompt header of `comment-code`"
  :type 'string
  :group 'chatgpt-shell)

(defun chatgpt-shell-comment-code ()
  "Writes a comment for the code in the region."
  (interactive)
  (chatgpt-shell-send-region-with-header chatgpt-shell-prompt-header-comment-code))

(defun chatgpt-shell-proofread-region ()
  "Proofreads the selected region using the ChatGPT buffer"
  (interactive)
  (if (get-buffer "*chatgpt")
    (with-current-buffer "*chatgpt*"
      (chatgpt-shell-clear-buffer)))
  (mapc (lambda (buffer)
          (when (string-prefix-p "*ChatGPT>" (buffer-name buffer))
            (when (get-buffer-window buffer 'visible)
              (delete-window (get-buffer-window buffer)))
            (kill-buffer buffer)))
        (buffer-list))
  (chatgpt-shell-send-to-buffer (concat "Please help me proofread the following text:\n\n"
                                        (buffer-substring-no-properties (region-beginning) (region-end)))))


(defun chatgpt-shell-write-commit-message ()
  "Writes a git commit message using the ChatGPT buffer"
  (interactive)
  (if (get-buffer "*chatgpt")
    (with-current-buffer "*chatgpt*"
      (chatgpt-shell-clear-buffer)))
  (let* ((diff (get-git-staged-diff-as-string))
         (message (concat "Write a git commit message for the following diff. Must follow best practices. Must start with a verb.\n\n" diff)))
    (mapc (lambda (buffer)
            (when (string-prefix-p "*ChatGPT>" (buffer-name buffer))
              (when (get-buffer-window buffer 'visible)
                (delete-window (get-buffer-window buffer)))
              (kill-buffer buffer)))
          (buffer-list))
    (chatgpt-shell-send-to-buffer message)))

(defun get-git-staged-diff-as-string ()
  "Returns a string that contains the diff of the current git stage"
  (with-temp-buffer
    (let ((diff-buffer-name "*git-staged-diff*")
          (default-directory (magit-toplevel)))
      (call-process "git" nil t nil "diff" "--staged")
      (buffer-string))))
