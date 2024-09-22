;; Set default working directory to home
(setq default-directory "~/")

;; Set default font size to 140
(set-face-attribute 'default nil :height 140)

;; Turn off the visual toolbar
(tool-bar-mode -1)

;; ensure text scaling applies to all buffers, not just current buffer
(defadvice text-scale-increase (around all-buffers (arg) activate)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      ad-do-it)))

;; Bring new emacs frames to foreground when opened
;; https://korewanetadesu.com/emacs-on-os-x.html
(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))

  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))

  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)

  (when (display-graphic-p)
    (ns-raise-emacs)))
