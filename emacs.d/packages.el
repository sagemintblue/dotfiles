(require 'package)

;; add MELPA (Milkypostman’s Emacs Lisp Package Archive) to list of package archives
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; for visually scaling text in a rational way
(use-package default-text-scale)

;; for "unfilling" paragraphs
(use-package unfill)
