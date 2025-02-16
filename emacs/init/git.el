(use-package magit
  :straight   t
  :general
  (:states    'normal
   "+"        'magit-status)
  (:keymaps   '(magit-status-mode-map magit-diff-mode-map magit-process-mode-map magit-log-mode-map)
   "<escape>" 'magit-mode-bury-buffer
   "$"        'magit-process-buffer))

(use-package diff-hl
  :straight t
  :config
  (global-diff-hl-mode 1)
  (diff-hl-margin-mode 1)
  (setq diff-hl-margin-symbols-alist '((insert . "▍") (delete . "▍") (change . "▍") (unknown . "▍") (ignored . "▍")))
  (set-face-attribute 'diff-hl-margin-insert nil :foreground "#9fbd70" :inherit nil)
  (set-face-attribute 'diff-hl-margin-delete nil :foreground "#ee756f" :inherit nil)
  (set-face-attribute 'diff-hl-margin-change nil :foreground "#e5c084" :inherit nil))
