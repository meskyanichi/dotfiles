(use-package rust-mode
  :straight t
  :custom
  (rust-format-on-save t)
  :general
  (:keymaps 'rust-mode-map
   :states  'normal
   ", r"    'rust-run
   ", t"    'rust-test
   ", b"    'rust-compile))
