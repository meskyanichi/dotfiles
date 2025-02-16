(use-package emmet-mode
  :straight t
  :hook ((sgml-mode css-mode) . emmet-mode)
  :general
  (:states   'insert
   "C-<tab>" 'emmet-expand-line))

(use-package web-mode
  :straight t
  :mode (("\\.erb\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.scss\\'" . web-mode)
         ("\\.sass\\'" . web-mode))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(use-package js2-mode
  :straight t
  :mode ("\\.js\\'" . js2-mode)
  :custom
  (js2-strict-missing-semi-warning nil)
  (js2-basic-offset 2))

(general-define-key
 :keymaps 'mhtml-mode-map
 "§" nil)
