;; init-local ---- Local settings for emacs
;;; Commentary:

;;; Code:

;; Enable Monokai
;; NOTE: Requires disabling (require 'init-themes) in init.el
(require-package 'monokai-theme)
(load-theme 'monokai)
(setq-default custom-enabled-themes '(monokai))

;; Disable saving list of open files
(desktop-save-mode 0)

;; Store all backup and autosave files in the tmp dir
;; Overrides default of saving in current directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Enable colors in *shell* instances
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; Add Jade mode
(require-package 'jade-mode)

;; Add Java mode
(require-package 'malabar-mode)

;; Force .h files to open in C++ Mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Add web-mode
(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Enable time display
(display-time-mode 1)
(setq display-time-format "%l:%M %p")

;; Enable Git highlighting in gutter
(require-package 'git-gutter)
(global-git-gutter-mode +1)
(set-face-background 'git-gutter:modified "purple4")
(set-face-foreground 'git-gutter:added "green4")
(set-face-foreground 'git-gutter:deleted "red4")

;; Enable highlighted column 80
(require-package 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-color "darkgray")
(add-hook 'after-change-major-mode-hook 'fci-mode)
(fci-mode 1)

;; Enable Zsh in Emacs shell-mode
(setq system-uses-terminfo nil)

;; Use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; Customize mode line
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
