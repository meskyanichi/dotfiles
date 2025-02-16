(use-package aider
  :straight (:host github :repo "tninja/aider.el" :files ("aider.el"))
  :general (:states '(normal) "§ a" 'aider-transient-menu)
  :config
  (setenv "OPENAI_API_KEY" (read-op-item "op://Shared/OpenAI/emacs-key"))
  (setenv "GEMINI_API_KEY" (read-op-item "op://Private/Google/emacs-key"))
  (setq aider-args '("--model" "gemini/gemini-2.0-flash" "--weak-model" "gemini/gemini-2.0-flash")))

(eval-after-load 'aider
  '(setq aider-popular-models
         '("o3-mini" "gemini/gemini-2.0-flash")))
