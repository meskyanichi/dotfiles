(use-package popwin
  :straight t
  :init
  (popwin-mode 1)

  :general
  (:states  'normal
   "M-k"    'popwin:close-popup-window
   "M-b"    'popwin:popup-last-buffer)

  :config
  (push '("*shell*" :height 20 :position bottom :stick t)
        popwin:special-display-config)
  (push '("*Async Shell Command*" :height 20 :position bottom :stick t)
        popwin:special-display-config)
  (push '(minitest-compilation-mode :width 0.5 :position right :noselect t :stick t)
        popwin:special-display-config))
