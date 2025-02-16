(setq remember-data-file "~/Documents/Notes/emacs")
(setq initial-buffer-choice 'remember-notes)
(add-hook 'emacs-startup-hook (lambda () (when (string= (buffer-name) "*notes*") (markdown-mode))))
(advice-add 'remember-notes :after (lambda (&rest _) (markdown-mode)))
