(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t
  :config
  (setq warning-suppress-types '((copilot)))
  (add-to-list 'warning-suppress-types '(copilot))
  (add-hook 'prog-mode-hook 'copilot-mode)
  (add-hook 'after-init-hook 'global-copilot-mode)
  :general
  (:states 'insert
   "s-/" 'copilot-next-completion
   "s-<return>" 'copilot-accept-completion
   "s-c" 'copilot-mode)
  (:states 'normal
   "s-/" 'copilot-mode))
