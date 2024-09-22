(defun upcase-char ()
  "Upcase the character at point."
  (interactive)
  (upcase-region (point) (1+ (point))))

(defun downcase-char ()
  "Downcase the character at point."
  (interactive)
  (downcase-region (point) (1+ (point))))

(defun togglecase-char ()
  "Toggles the case of the character at point."
  (interactive)
  (let ((c (buffer-substring (point) (1+ (point)))))
    (if (string= c (downcase c))
        (upcase-char)
      (downcase-char)
      )))
