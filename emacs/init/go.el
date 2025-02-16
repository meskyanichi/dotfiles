(use-package go-mode
  :straight t
  :hook (before-save . gofmt-before-save))
