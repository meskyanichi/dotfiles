(use-package python
  :mode ("\\.py\\'" . python-mode)
  :init
  (setq-default indent-tabs-mode nil
                tab-width 4
                python-indent-offset 4)
  :hook
  (python-mode . (lambda ()
                   (setq indent-tabs-mode nil
                         tab-width 4
                         python-indent-offset 4))))
