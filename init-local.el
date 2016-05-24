;; init-local ---- Local settings for emacs
;;; Commentary:

;;; Code:


;; --------------------------------- ;;
;; Overrides of purcell/.emacs.d
;; --------------------------------- ;;

;; Disable saving list of open files
(desktop-save-mode 0)

;; Disable Company autocomplete
(setq company-global-modes 'nil)

;; Store all backup and autosave files in the tmp dir
;; Overrides default of saving in current directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; --------------------------------- ;;
;; Package Installs
;; --------------------------------- ;;

(require-package 'buffer-move) ;; Switch buffers between panes
(require-package 'git-gutter)
(require-package 'fill-column-indicator) ;; Draw line at column
(require-package 'jade-mode)
(require-package 'malabar-mode) ;; Java mode
(require-package 'monokai-theme)
(require-package 'web-mode)


;; --------------------------------- ;;
;; Configuration
;; --------------------------------- ;;

;; Enable Monokai theme
(load-theme 'monokai)
(setq-default custom-enabled-themes '(monokai))

;; Enable web mode
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Force .h files to open in C++ Mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Enable time display
(display-time-mode 1)
(setq display-time-format "%l:%M %p")

;; Enable Git highlighting in gutter
(global-git-gutter-mode +1)
(set-face-background 'git-gutter:modified "purple4")
(set-face-foreground 'git-gutter:added "green4")
(set-face-foreground 'git-gutter:deleted "red4")

;; Enable highlighting text that goes beyond column 80
(setq-default
 whitespace-line-column 80 ;; Set column 80 to length limit
 whitespace-style '(face lines-tail)) ;; Highlight text beyond length limit
(set-face-attribute 'whitespace-line nil
                    :foreground "Red3"
                    :background nil
                    :weight 'bold)
(add-hook 'prog-mode-hook #'whitespace-mode) ;; Activate in programming mode

;; Enable Zsh in Emacs shell-mode
(setq system-uses-terminfo nil)

;; Set Zsh to default terminal for ansi-term
(setq-default explicit-shell-file-name "/bin/zsh")

;; Use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; Customize mode line
;; The changes from the default configuration are the
;; commented out lines
(setq-default mode-line-format '(" "
                                 ;;    mode-line-mule-info
                                 ;;    mode-line-modified
                                 ;;    mode-line-frame-identification
                                 mode-line-buffer-identification
                                 "   "
                                 mode-line-position
                                 (vc-mode vc-mode)
                                 "   "
                                 mode-line-modes
                                 (which-func-mode ("" which-func-format "--"))
                                 (global-mode-string ("--" global-mode-string))
                                 "-%-"))

(provide 'init-local)
;;; init-local ends here
