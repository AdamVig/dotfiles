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
    (add-node-modules-path prettier-js git-commit yaml-mode go-mode atom-one-dark-theme editorconfig use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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