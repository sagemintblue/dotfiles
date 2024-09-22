(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-name-width 80)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes '(deeper-blue))
 '(ensime-startup-notification nil)
 '(fill-column 100)
 '(ibuffer-formats
   '((mark modified read-only locked " "
           (name 40 -1)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename)))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-major-mode 'text-mode)
 '(js-indent-level 2)
 '(make-backup-files nil)
 '(package-selected-packages
   '(company typescript-mode company-lsp json-mode js2-mode yasnippet lsp-ui lsp-metals lsp-mode flycheck sbt-mode unfill magit use-package yaml-mode thrift scala-mode default-text-scale))
 '(python-indent-offset 2)
 '(show-paren-mode t)
 '(standard-indent 2)
 '(tramp-verbose 3))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Emacs configuration, modularized
;; See https://stackoverflow.com/a/2079146/127703

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file from current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "packages.el")
(load-user-file "utils.el")
(load-user-file "interface.el")
(load-user-file "hooks.el")
(load-user-file "scala.el")
(load-user-file "editorconfig.el")
(load-user-file "keys.el")
