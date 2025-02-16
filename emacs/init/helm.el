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
