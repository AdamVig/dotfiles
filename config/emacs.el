;;; emacs.el --- Configure Emacs.
;;; Commentary:

;;; This file configures Emacs.  See the bottom of the file for instructions on providing local, machine-specific configuration.

;;; Code:

;; Initialize package.el (http://melpa.org/#/getting-started)
(require 'package)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/") t)
(package-initialize)

;; Install and set up use-package (https://github.com/jwiegley/use-package)
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-commit-summary-max-length 72)
 '(org-agenda-prefix-format
		'((agenda . "")
			 (todo . " %i %-12:c")
			 (tags . " %i %-12:c")
			 (search . " %i %-12:c")))
 '(org-agenda-scheduled-leaders '("" "[Overdue %d days] "))
 '(org-agenda-sorting-strategy
		'((agenda todo-state-up priority-down)
			 (todo priority-down category-keep todo-state-up)
			 (tags priority-down category-keep)
			 (search category-keep)))
 '(org-agenda-span 'day)
 '(org-agenda-window-setup 'only-window)
 '(org-archive-location "%s-archive::")
 '(org-babel-load-languages '((emacs-lisp . t) (shell . t)))
 '(org-confirm-babel-evaluate nil)
 '(org-export-with-toc nil)
 '(org-html-checkbox-type 'html)
 '(org-html-doctype "html5")
 '(org-html-html5-fancy t)
 '(package-selected-packages
		'(auto-package-update flycheck forge olivetti super-save company tide ox-gfm i3wm-config-mode writegood-mode markdown-mode magit add-node-modules-path prettier-js git-commit yaml-mode go-mode editorconfig use-package))
 '(reb-re-syntax 'string)
 '(use-short-answers t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit default :extend nil :foreground "#DCDCCC" :weight bold))))
 '(org-level-2 ((t (:foreground "#DCDCCC" :weight light))))
 '(variable-pitch ((t (:family "Input Sans")))))

;; Install and set up auto-package-update (https://github.com/rranelli/auto-package-update.el)
(use-package auto-package-update
  :ensure t
  :config
	;; Set automatic update interval (in days)
	(setq auto-package-update-interval 7)
	;; Do not prompt before running update
	(setq auto-package-update-prompt-before-update nil)
	;; Delete old versions after updating
	(setq auto-package-update-delete-old-versions t)
	;; Show summary after updating
	(setq auto-package-update-hide-results t))

;; On macOS, start a server when in a graphical instance and the server is not already running
(require 'server) ;; Ensure server package is loaded so we can use functions from it
(if (and (eq system-type 'darwin) window-system (not (server-running-p)))
	(server-start)
)

;; On macOS, set PATH (used by shells) to include Homebrew's binary directory
;; It would be better to launch Emacs.app in a shell context that already has the correct environment variables set
(if (eq system-type 'darwin) (setenv "PATH" (concat (getenv "PATH") ":/opt/homebrew/bin:/opt/homebrew/sbin")))

;; Add exec-path-from-shell (https://github.com/purcell/exec-path-from-shell)
(use-package exec-path-from-shell
	:ensure t
	:config (exec-path-from-shell-initialize))

;; Set the font and font size (in 1/10pt), custom for macOS
(if (eq system-type 'darwin)
	(set-face-attribute 'default nil :font "Input Mono" :height 160)
	(set-face-attribute 'default nil :font "Input Mono" :height 120)
)

;; Customize the mode line
(setq-default mode-line-format
	(list
		mode-line-front-space
		mode-line-buffer-identification
		"  "
		"Line %l, Column %c"
		mode-line-end-spaces
	  )
	)

;; Install and set up Helpful (https://github.com/Wilfred/helpful)
(use-package helpful
  :ensure t
	:config
	(global-set-key (kbd "C-h f") #'helpful-callable)
	(global-set-key (kbd "C-h v") #'helpful-variable)
	(global-set-key (kbd "C-h k") #'helpful-key))

;; Install and set up EditorConfig (https://github.com/editorconfig/editorconfig-emacs)
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(setq backup-inhibited t) ; Disable backup
(setq auto-save-default nil) ; Disable auto save
(setq inhibit-startup-screen t) ; Disable startup screen
(setq ring-bell-function 'ignore) ; Disable audio bell
(setq initial-scratch-message "") ; Disable scratch buffer comment
(setq column-number-mode t) ; Enable column number
(if (functionp 'tool-bar-mode) (tool-bar-mode -1)) ; Disable toolbar
(if (functionp 'menu-bar-mode) (menu-bar-mode -1)) ; Disable menu bar
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1)) ; Disable scrollbar

;; Automatically revert dired buffer when files change
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; Automatically save buffer when idle (https://github.com/bbatsov/super-save)
(use-package super-save
  :ensure t
  :config
  (super-save-mode +1)
	(setq super-save-auto-save-when-idle t))

;; Enable shortcut for Ibuffer mode (https://www.emacswiki.org/emacs/IbufferMode)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Enable typing over a selection (https://www.emacswiki.org/emacs/DeleteSelectionMode)
(delete-selection-mode 1)

;; Hide buffers that start with an asterisk in Ibuffer mode
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")

;; Hide commands that do not apply to the current buffer's mode
(setq read-extended-command-predicate #'command-completion-default-include-p)

;; Install and enable vertico (https://github.com/emacs-straight/vertico)
(use-package vertico
	:ensure t
  :init
  (vertico-mode))

;; Install and enable Orderless completion style (https://github.com/oantolin/orderless)
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Install and use Zenburn Theme (https://github.com/bbatsov/zenburn-emacs)
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;; Install Olivetti (https://github.com/rnkn/olivetti/)
(use-package olivetti
  :ensure t)

;; Add go-mode and automatic format/import on save
(use-package go-mode
  :ensure t)
(add-hook 'go-mode-hook (lambda () (
  add-hook 'before-save-hook 'gofmt-before-save)
 (setq gofmt-command "goimports")))

;; Add mode for i3 config files (https://github.com/Alexander-Miller/i3wm-Config-Mode)
(use-package i3wm-config-mode
	:ensure t)

;; Add and configure Markdown mode (https://github.com/jrblevin/markdown-mode)
(use-package markdown-mode
	:ensure t
	:mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Add yaml-mode and add handling for .yml files
(use-package yaml-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Add git-commit mode
(use-package git-commit
  :ensure t
  :config (add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell))

;; Add and configure with-editor mode (https://github.com/magit/with-editor)
(use-package with-editor
  :ensure t
  ;; Allow commit-like behavior when editing Graphite pull request descriptions
  :config (add-to-list 'auto-mode-alist '("GRAPHITE_PR_DESCRIPTION\\.md\\'" . with-editor-mode)))

;; Allow usage of project-local npm packages
(use-package add-node-modules-path
  :ensure t
  :config (add-hook 'js-mode-hook 'add-node-modules-path))

;; Add Prettier
(use-package prettier-js
  :ensure t
  :config (add-hook 'js-mode-hook 'prettier-js-mode))

;;; Org mode
;; Disable "Validate" link in Org HTML exports
(setq org-html-validation-link nil)
;; Set global key binding for org-agenda
(global-set-key (kbd "C-c a") 'org-agenda)
;; Set global key binding for inserting inactive time stamp
(global-set-key (kbd "C-c !") 'org-time-stamp-inactive)
;; Set global key binding for org-capture
(global-set-key (kbd "C-c c") 'org-capture)
;; Open Org files folded
(setq org-startup-folded t)

;; Add org-modern (https://github.com/minad/org-modern)
(use-package org-modern-mode
	:ensure t)

(use-package writegood-mode
	:ensure t
	:config (global-set-key "\C-cg" 'writegood-mode))

;; https://stackoverflow.com/a/27043756/1850656
(defun org-archive-done-tasks ()
	"Archive all DONE tasks in the current Org mode file and save all Org files."
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point)))
		 (org-save-all-org-buffers))
    "/DONE" 'file))

(use-package ox-gfm
	:ensure t)

(add-hook 'org-mode-hook
  (lambda ()
		(local-set-key (kbd "C-c s") 'org-archive-done-tasks)
		(require 'ox-md nil t)
		(require 'ox-gfm nil t)
		;; Automatically revert buffer when file changes on disk
		(auto-revert-mode)
		;; Enable visual line wrapping
		(visual-line-mode)
		;; Enable non-monospaced font
		(variable-pitch-mode)
		))
(add-hook 'org-agenda-mode-hook
	;; Enable non-monospaced font
	'variable-pitch-mode)

;; Https://emacsredux.com/blog/2013/04/02/move-current-line-up-or-down/
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(meta p)]  'move-line-up)
(global-set-key [(meta n)]  'move-line-down)

;; Add Magit (https://magit.vc/)
(use-package magit
	:ensure t)

;; Add Magit Forge (https://magit.vc/manual/forge/)
(use-package forge
	:ensure t
	:after magit)

;; Add Company mode (https://company-mode.github.io/)
(use-package company
  :ensure t
  :init (global-company-mode t)
	:config (setq company-global-modes '(not org-mode git-commit)))

;; Add Flycheck (https://github.com/flycheck/flycheck)
(use-package flycheck
	:ensure t
	:init (global-flycheck-mode))

;; Add TypeScript Interactive Development Environment (https://github.com/ananthakumaran/tide)
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck exec-path-from-shell)
  :hook ((typescript-mode . tide-setup)
					(typescript-mode . tide-hl-identifier-mode)))

;; Use sh-mode for local shell files
(add-to-list 'auto-mode-alist '(".locals" . sh-mode))
(add-to-list 'auto-mode-alist '(".profile-local" . sh-mode))

;; Load all Lisp files in the `lisp/` subdirectory of the user's Emacs directory
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Load user-specific settings if present
;; To add user-specific settings, create a file in `<your Emacs directory>/lisp` containing `(provide 'init-local)`
(require 'init-local nil t)

(provide 'emacs)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:
;;; emacs.el ends here
