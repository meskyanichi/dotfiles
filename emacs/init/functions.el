;;; Buffer Management
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun kill-this-buffer-unless-scratch ()
  "Kill current buffer unless it's *scratch*."
  (interactive)
  (if (string= (buffer-name) "*scratch*")
      (previous-buffer)
    (kill-this-buffer)))

(defun switch-to-scratch-buffer ()
  "Switch to the scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))

;;; Font Management
(defvar font-type nil "Current font type.")
(defvar font-size nil "Current font size.")

(defun set-font (type size)
  "Set font TYPE and SIZE."
  (interactive)
  (setq font-type type
        font-size size)
  (set-frame-font (concat type " " (number-to-string size))))

(defun reset-font () (interactive) (set-font font-type 15))
(defun increase-font ()
  (interactive)
  (when (< font-size 30)
    (set-font font-type (1+ font-size))))
(defun decrease-font ()
  (interactive)
  (when (> font-size 5)
    (set-font font-type (1- font-size))))

;;; Theme Management
(defvar theme "wombat")
(defvar themes '(wombat))
(defvar themes-set nil)

(defun set-themes (theme-list)
  "Configure THEME-LIST for cycling."
  (unless themes-set
    (setq themes-set t
          themes theme-list)
    (cycle-themes)))

(defun cycle-themes ()
  "Cycle through defined themes."
  (interactive)
  (let ((theme (pop themes)))
    (setq themes (append themes (list theme)))
    (disable-theme theme)
    (load-theme theme t)
    (message "%s" theme)
    (setq theme theme)
    theme))

;;; Utility Functions
(defun disable-warnings ()
  "Disable non-emergency warnings."
  (interactive)
  (setq warning-minimum-level :emergency))

(defun cycle-language ()
  "Cycle between en_US and nl dictionaries."
  (interactive)
  (let ((dir "~/Documents/.aspell/"))
    (f-mkdir dir)
    (if (string= "en_US" ispell-current-dictionary)
        (progn
          (ispell-change-dictionary "nl")
          (setq ispell-personal-dictionary (concat dir "nl.pws")))
      (progn
        (ispell-change-dictionary "en_US")
        (setq ispell-personal-dictionary (concat dir "en_US.pws"))))
    (flyspell-buffer)))

(defun align-by-equals-symbol (begin end)
  "Align = signs in region."
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\)=" 1 1))

(defun insert-euro-symbol () (interactive) (insert "€"))
(defun insert-paragraph-symbol () (interactive) (insert "§"))

;;; Package Management
(defun upgrade-packages ()
  "Upgrade packages and update lockfile."
  (interactive)
  (straight-pull-all)
  (straight-freeze-versions))

(defun rollback-packages ()
  "Rollback packages using lockfile."
  (interactive)
  (shell-command "git -C $HOME/.dotfiles checkout -- emacs/straight.lock.el"))

;;; 1Password Integration
(defvar op-item-cache nil)

(defun read-op-item (op-item-path)
  "Read and cache 1Password item."
  (or (cdr (assoc op-item-path op-item-cache))
      (let ((key (string-trim-right
                  (shell-command-to-string (format "op read %s" op-item-path)))))
        (unless (string-match-p "\\[ERROR\\]" key)
          (push (cons op-item-path key) op-item-cache)
          key))))
