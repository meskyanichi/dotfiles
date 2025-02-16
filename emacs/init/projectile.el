(use-package projectile
  :straight t
  :after    evil
  :general
  (:states  'normal
   "!"      'projectile-run-async-shell-command-in-root
   "s-r"    'projectile-replace)
  :init     (projectile-mode 1))
