;;; Core Packages
(use-package which-key
  :straight t
  :config
  (which-key-mode 1))

(use-package general
  :straight t
  :config
  (general-auto-unbind-keys))

;;; Evil Configuration
(use-package evil
  :straight t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  :config
  (evil-mode 1)
  :general
  (:states  'normal
   "U"      'undo-redo)
  (:states  'visual
   ">"      'evil-shift-right-visual
   "<"      'evil-shift-left-visual
   "+"      'align-by-equals-symbol)
  (:states  'insert
   "M-§"    'insert-paragraph-symbol
   "M-2"    'insert-euro-symbol))

(use-package evil-collection
  :after evil
  :straight t
  :config
  (evil-collection-init))

;;; Evil Helper Functions
(defun evil-shift-left-visual ()
  "Shifts left while keeping selection."
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun evil-shift-right-visual ()
  "Shifts right while keeping selection."
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

;;; Global Keybindings
(general-define-key
 ;; Window Management
 "M-<tab>" 'evil-window-next
 "s-§"     'other-window
 "M-§"     'other-window
 "s-w"     'delete-window
 "M-f"     'delete-other-windows

 ;; Buffer Management
 "s-B"     'previous-buffer
 "s-k"     'kill-this-buffer-unless-scratch
 "s-K"     'kill-other-buffers

 ;; Font Size
 "s-="     'increase-font
 "s--"     'decrease-font
 "s-0"     'reset-font

 ;; Misc Functionality
 "s-q"     nil
 "§ q q"   'delete-frame
 "§ q k"   'kill-emacs
 "§ q r"   'restart-emacs
 "§ n"     'remember-notes
 "§ t"     'cycle-themes
 "§ l"     'cycle-language
 "§ L"     'flyspell-buffer)

;;; Which-key Descriptions
(which-key-add-key-based-replacements
 "§ f" "find"
 "§ q" "quit")

;;; Evil Normal State Keybindings
(general-define-key
 :keymaps '(evil-normal-state-map)
 "Q" 'kmacro-end-and-call-macro)
