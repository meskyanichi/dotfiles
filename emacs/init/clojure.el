(use-package clojure-mode
  :straight t
  :hook (clojure-mode . parinfer-mode)
  :custom
  (clojure-indent-style 'align-arguments)
  (clojure-align-forms-automatically t))

(use-package cider
  :straight t
  :after clojure-mode
  :general
  (:keymaps 'clojure-mode-map
   :states  'normal
   ", r j"  'cider-jack-in-clj
   ", r c"  'cider-connect-clj)
  (:keymaps 'clojurescript-mode-map
   :states  'normal
   ", c j"  'cider-jack-in-cljs
   ", c c"  'cider-connect-cljs)
  :custom
  (cider-enhanced-cljs-completion-p nil)
  :init
  (add-to-list 'safe-local-variable-values
               '(cider-default-cljs-repl . shadow))
  (add-to-list 'safe-local-variable-values
               '(cider-shadow-default-options . "app")))
