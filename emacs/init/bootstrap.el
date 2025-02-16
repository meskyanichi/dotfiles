;; Boot Performance Optimizations
(setq gc-cons-threshold most-positive-fixnum)  ; Set GC threshold very high during init for faster startup

;; File Management
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      temporary-file-directory  "~/.emacs.d/tmp"
      custom-file "~/.emacs.d/custom.el")
;; Create temporary file directory if it doesn't exist
(unless (file-exists-p "~/.emacs.d/tmp")
  (make-directory "~/.emacs.d/tmp" t))

;; UI & Scrolling
(setq inhibit-startup-message t                ; Disable startup message
      initial-scratch-message nil              ; Clear scratch buffer message
      fill-column 80                           ; Set default text width
      confirm-nonexistent-file-or-buffer nil   ; Auto-create buffers/files
      ring-bell-function 'ignore               ; Disable audible bell
      scroll-margin 1                          ; Margin at top/bottom when scrolling
      scroll-conservatively 10000              ; Prevent recentering on cursor movement
      scroll-step 1                            ; Scroll one line at a time
      auto-window-vscroll nil)                 ; Disable automatic vertical scrolling
(tool-bar-mode 0)                              ; Disable the toolbar
(menu-bar-mode 0)                              ; Disable the menu bar
(scroll-bar-mode 0)                            ; Disable the scroll bar
(set-fringe-mode 0)                            ; Minimize fringe size
(column-number-mode 1)                         ; Show column numbers in status bar
(fset 'yes-or-no-p 'y-or-n-p)                  ; Simplify yes/no prompts

;; Package Management
(require 'package)                             ; Load built-in package management
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))  ;; Set package archive
(package-initialize)                           ; Initialize packages

;; Bootstrap straight.el for package management from source
(defvar bootstrap-version)
(let ((bootstrap-file "~/.emacs.d/straight/repos/straight.el/bootstrap.el")
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)       ; If straight.el bootstrap file is missing...
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))                 ; ...download and execute it
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)            ; Ensure use-package is managed with straight.el
(setq system-packages-use-sudo nil)            ; Disable sudo for system package installations

;; Finalization
;; After startup, lower GC threshold to 16MB and log the startup time
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216)  
            (message "Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time (time-subtract after-init-time before-init-time)))
                     gcs-done)))
