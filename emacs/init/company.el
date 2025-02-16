(use-package company
  :straight   t
  :general
  (:keymaps   'company-active-map
   "C-j"      'company-select-next-or-abort
   "C-k"      'company-select-previous-or-abort
   "<escape>" 'company-abort)
  :init       (add-hook 'after-init-hook 'global-company-mode))
