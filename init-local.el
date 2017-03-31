;; init-local ---- Local settings for emacs
;;; Commentary:

;;; Code:

;; Declare functions and variables that will be available in the global scope
(declare-function require-package "init-elpa")
(declare-function global-git-gutter-mode "git-gutter")
(declare-function editorconfig-mode "editorconfig-mode")
(declare-function company-quickhelp-mode "company-quickhelp-mode")
(defvar org-replace-disputed-keys)
(defvar js2-mode-map)

;; ---------------------------------
;; Overrides of purcell/.emacs.d
;; ---------------------------------

;; Disable saving list of open files
(desktop-save-mode 0)

;; Store all backup and autosave files in the tmp dir
;; Overrides default of saving in current directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; ----------------------------------
;; Overrides of standard Emacs config
;; ----------------------------------

;; Replace S-<cursor> commands with:
;;   M--, M-+ for org-shiftleft and org-shiftright
;;   M-p, M-n for org-shiftdown and org-shiftup
;;   M-S--, M-S-+ for org-shiftcontrolleft and org-shiftcontrolright
(setq org-replace-disputed-keys t)


;; ---------------------------------
;; Package Installs
;; ---------------------------------

(require-package 'buffer-move)    ;; Switch buffers between panes
(require-package 'editorconfig)    ;; Support .editorconfig settings
(require-package 'emmet-mode)    ;; HTML expansion
(require-package 'git-gutter)
(require-package 'fill-column-indicator)    ;; Draw line at column
(require-package 'jade-mode)
(require-package 'malabar-mode)    ;; Java mode
(require-package 'monokai-theme)
(require-package 'restclient)    ;; REST API exploration tool
(require-package 'tide)    ;; TypeScript Interactive Development Environment
(require-package 'web-mode)


;; ---------------------------------
;; Language Configuration
;; ---------------------------------

;; Enable web mode
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Enable JSX mode
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))

;; Enable web mode for Vue files
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))

;; Enable Prolog mode
(add-to-list 'auto-mode-alist '("\\.pro?\\'" . prolog-mode))

;; Enable Emmet HTML expansion for markup and CSS modes
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

;; Force .h files to open in C++ Mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Set default indentation
(setq-default js2-basic-offset 4)

;; Ignore "Not following external source" bash error
(setq-default flycheck-shellcheck-excluded-warnings '("SC1091"))

;; Set up TypeScript
(defun setup-tide-mode ()
  "Set up Tide mode for TypeScript."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq-default flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; Aligns annotation to the right hand side
(setq-default company-tooltip-align-annotations t)

;; Formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; ---------------------------------
;; Editor Configuration
;; ---------------------------------

;; Enable editorconfig
(editorconfig-mode 1)

;; Enable Monokai theme
(load-theme 'monokai)
(setq-default custom-enabled-themes '(monokai))

;; Enable time display
(display-time-mode 1)
(setq-default display-time-format "%l:%M %p")

;; Enable Git highlighting in gutter
(unless (display-graphic-p)
  (global-git-gutter-mode t)
  (set-face-background 'git-gutter:modified "purple4")
  (set-face-foreground 'git-gutter:added "green4")
  (set-face-foreground 'git-gutter:deleted "red4"))

;; Enable highlighting text that goes beyond column 80
(setq-default
 whitespace-line-column 80    ;; Set column 80 to length limit
 whitespace-style '(face lines-tail))    ;; Highlight text beyond length limit
(set-face-attribute 'whitespace-line nil
                    :foreground "Red3"
                    :background nil
                    :weight 'bold)
(add-hook 'prog-mode-hook #'whitespace-mode)    ;; Activate in programming mode

;; Disable display of trailing whitespace in Markdown mode
(defun disable-show-trailing-whitespace ()
  "Disable display of trailing whitespace."
  (setq show-trailing-whitespace nil))
(add-hook 'markdown-mode-hook 'disable-show-trailing-whitespace)
(add-hook 'org-mode-hook 'disable-show-trailing-whitespace)

;; Customize color of trailing whitespace highlight
(set-face-background 'trailing-whitespace "coral")

;; Enable Zsh in Emacs shell-mode
(setq system-uses-terminfo nil)

;; Set Zsh to default shell
(setq-default explicit-shell-file-name
              ;; Remove newline from end of command output
              (replace-regexp-in-string "\n$" ""
                                        ;; Get location of zsh executable
                                        (shell-command-to-string "which zsh")))

(defadvice ansi-term (before force-bash)
  "Suppress 'ansi-term' Run program prompt.
When 'ansi-term' command is run, supply the value of the
explicit shell variable set above."
  (interactive (list explicit-shell-file-name)))
(ad-activate 'ansi-term)

;; Use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings 'meta)

;; Add keybindings for js-doc
(setq-default js2-indent-switch-body t)

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
                                 ;;mode-line-modes
                                 (which-func-mode ("" which-func-format "--"))
                                 (global-mode-string ("--" global-mode-string))
                                 "-%-"))

(provide 'init-local)
;;; init-local ends here
