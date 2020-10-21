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
	'(package-selected-packages
		 (quote
			 (unicode-fonts i3wm-config-mode writegood-mode markdown-mode magit add-node-modules-path prettier-js git-commit yaml-mode go-mode atom-one-dark-theme editorconfig use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set the font and font size (in 1/10pt)
(set-face-attribute 'default nil :font "Fira Code" :height 120)

;; Add cache for unicode-fonts package
(use-package persistent-soft
	:ensure t)

;; Configure Unicode fonts (https://github.com/rolandwalker/unicode-fonts)
(use-package unicode-fonts
	:ensure t
	:config
	(unicode-fonts-setup))

;; Customize the mode line
(setq-default mode-line-format
	(list
		mode-line-front-space
		mode-line-buffer-identification
		"  "
		"Line %l, Column %c"
		"  "
		mode-line-modes
		mode-line-end-spaces
	  )
	)

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
(tool-bar-mode -1) ; Disable toolbar
(menu-bar-mode -1) ; Disable menu bar
(scroll-bar-mode -1) ; Disable scrollbar

;; Enable shortcut for Ibuffer mode (https://www.emacswiki.org/emacs/IbufferMode)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Hide buffers that start with an asterisk in Ibuffer mode
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")

;; Install and enable undo-tree (https://elpa.gnu.org/packages/undo-tree.html)
(use-package undo-tree
	:ensure t
	:config
	(global-undo-tree-mode))

;; Install and enable Counsel, Ivy, and Swiper (https://github.com/abo-abo/swiper)
(use-package counsel
	:ensure t
	:config
	(ivy-mode 1)
	;; Show both the current number of matches and the total number of candidates
	(setq ivy-count-format "(%d/%d) "))

;; Install and use Zenburn Theme (https://github.com/bbatsov/zenburn-emacs)
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

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
  :ensure t)

;; Allow usage of project-local npm packages
(use-package add-node-modules-path
  :ensure t
  :config (add-hook 'js-mode-hook 'add-node-modules-path))

;; Add Prettier
(use-package prettier-js
  :ensure t
  :config (add-hook 'js-mode-hook 'prettier-js-mode))

;; Enable visual line wrapping in Org mode
(add-hook 'org-mode-hook 'visual-line-mode)
;; Disable "Validate" link in Org HTML exports
(setq org-html-validation-link nil)

(use-package writegood-mode
	:ensure t
	:config (global-set-key "\C-cg" 'writegood-mode))

;; Define function to archive all DONE tasks in Org mode (https://stackoverflow.com/a/27043756/1850656)
(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
      "/DONE" 'tree))

;; https://emacsredux.com/blog/2013/04/02/move-current-line-up-or-down/
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

(global-set-key [(meta u)]  'move-line-up)
(global-set-key [(meta p)]  'move-line-down)

;; Add Magit (https://magit.vc/)
(use-package magit
	:ensure t)

;; Load all Lisp files in the `lisp/` subdirectory of the user's Emacs directory
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Load user-specific settings if present
;; To add user-specific settings, create a file in `<your Emacs directory>/lisp` containing `(provide 'init-local)`
(require 'init-local nil t)
