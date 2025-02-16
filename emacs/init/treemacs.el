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
