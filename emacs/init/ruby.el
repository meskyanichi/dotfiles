(use-package enh-ruby-mode
  :straight t
  :mode (("\\.rb\\'" . enh-ruby-mode)
         ("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
  :general
  (:states  'normal
   "<tab>"    'hs-toggle-hiding
   "C-<tab>"  'enh-ruby-next-method)
  :init
  (add-hook 'enh-ruby-mode-hook
            (lambda ()
              (setq hs-special-modes-alist
                    (cons '(enh-ruby-mode
                           "\\(def\\|do\\|{\\)" "\\(end\\|}\\)" "#"
                           (lambda (arg) (ruby-end-of-block)) nil)
                          hs-special-modes-alist))
              (hs-minor-mode t))))

(defun enh-ruby-next-method ()
  "Move point to the beginning of the next method in enh-ruby-mode."
  (interactive)
  (when (looking-at "\\s-*def")
    (end-of-line))
  (unless (re-search-forward "\\s-*def" nil t)
    (goto-char (point-min))
    (re-search-forward "\\s-*def" nil t))
  (beginning-of-line))

;; Support packages
(use-package inf-ruby
  :straight t
  :hook (enh-ruby-mode . inf-ruby-minor-mode)
  :general
  (:states  'normal
   ", i i"  'inf-ruby
   ", i r"  'inf-ruby-console-rails-from-project-root
   ", i s"  'ruby-switch-to-inf)
  :config
  (defun inf-ruby-console-rails-from-project-root ()
    (interactive)
    (inf-ruby-console-rails (projectile-project-root))))

(use-package robe
  :straight t
  :hook (enh-ruby-mode . robe-mode)
  :general
  (:states 'normal
   "s-<return>" 'robe-jump)
  :config
  (eval-after-load 'company
    '(push 'company-robe company-backends)))

(use-package chruby
  :straight t
  :hook (enh-ruby-mode . chruby-use-corresponding))

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
            (lambda () (local-set-key (kbd "g g") 'evil-goto-first-line)))
  (defun simplecov-open ()
    (interactive)
    (projectile-run-shell-command-in-root "open coverage/index.html")))
