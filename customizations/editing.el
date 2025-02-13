;; Customizations relating to editing a buffer.

;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; line numbers
(global-display-line-numbers-mode 1)
;; but not everywhere
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)

;; shell scripts
(setq-default sh-basic-offset 2
              sh-indentation 2)

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
(save-place-mode 1)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files. This tells Emacs to
;; put all backups in ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)

;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; fix weird os x kill error
(defun ns-get-pasteboard ()
  "Returns the value of the pasteboard, or nil for unsupported formats."
  (condition-case nil
      (ns-get-selection-internal 'CLIPBOARD)
    (quit nil)))

(setq electric-indent-mode nil)

(use-package command-log-mode
  :init
  :ensure t
  :config
  (global-command-log-mode)
  ;(clm/open-command-log-buffer)
  )

;; (use-package org-ac
;;   :init
;;   :ensure t
;;   :config
;;   (org-ac/config-default))
  
(use-package org-re-reveal
  :init
  :ensure t)

(use-package graphviz-dot-mode
  :init
  :ensure t
  :config
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot)))

(use-package gnuplot 
  :init
  :ensure t
  :config
  (org-babel-do-load-languages
                      'org-babel-load-languages
                      '((emacs-lisp . t)
                        (dot . t)
                        (gnuplot . t)
                        (org . t)
                        (python . t))))

(use-package org
  :init
  :ensure t
  :config
  (add-to-list 'org-modules 'org-habit t))

(use-package org-habit-stats
  :init
  :ensure t
  :config
  (setq org-habit-show-habits-only-for-today nil))

(use-package org-download
  :init
  :ensure t
  :config
  (setq org-download-method 'directory)
  (setq org-download-image-dir "./images"))

(use-package company-jedi
  :init
  :ensure t
  :config
  (add-hook 'python-mode-hook 
            (lambda () (add-to-list 'company-backends 'company-jedi))))
