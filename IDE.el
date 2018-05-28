;; INSTALL PACKAGES
;; --------------------------------------

;; Enable package stuff
(require 'package)
(package-initialize)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    realgud 
    python-mode 
    auto-complete
    yasnippet
    magit
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)
      
;; recent files entry
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; prefer utf-8 as encoding
(prefer-coding-system 'utf-8)

;; set color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-blue2)
;; enable auto-complete
(global-auto-complete-mode t)

(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))

;; Creating a new menu pane in the menu bar to the right of “Tools” menu
(define-key-after
  global-map
  [menu-bar devtools]
  (cons "DevTools" (make-sparse-keymap "Bla"))
  'tools )

;; Key Bindings
;;(with-eval-after-load 'python-mode
(define-key global-map (kbd "s-d") 'comment-region) ;; comment a region by shortcut Super+d
(define-key global-map (kbd "s-D") 'uncomment-region) ;; uncomment a region by shortcut Super+Shift+d
(define-key global-map (kbd "C-r") 'query-replace)    ;; replace
(define-key global-map (kbd "C-f") 'search-forward)   ;; search

;;  )
(define-key global-map [menu-bar devtools comment] '("Comment Region" . comment-region))
(define-key global-map [menu-bar devtools uncomment] '("Unomment Region" . uncomment-region))

;;)
;;(require 'ido
;;(ido-mode t)
(require 'python-mode)
;;(add-hook 'python-mode-hook 'anaconda-mode)
;;(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
;; add scons file to the known python file list
(add-to-list 'auto-mode-alist '("\\SConstruct\\'" . python-mode))

;; Normal Copy paste
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Load yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; python mode settings
(global-eldoc-mode -1)
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "--simple-prompt -i")


;; Modified settings from RealPython
;; BASIC CUSTOMIZATION
;; --------------------------------------

;;(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
;;(elpy-use-ipython) ;; deprecated use jupyter instead
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")
             
;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
