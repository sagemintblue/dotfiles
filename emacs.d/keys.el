;; Common commands
(global-set-key (kbd "s-/") 'comment-or-uncomment-region)
(global-set-key (kbd "s-s") 'sort-lines)

;; Character case manipulation
(global-set-key (kbd "C-M-u") 'upcase-char)
(global-set-key (kbd "C-M-l") 'downcase-char)
(global-set-key (kbd "C-M-t") 'togglecase-char)

;; Open ibuffer menu in current window
(global-set-key "\C-x\C-b" 'ibuffer)

;; Rational window / frame navigation
(global-set-key (kbd "s-'") 'other-window)
(global-set-key (kbd "s-<right>") 'other-window)
(global-set-key (kbd "s-<left>") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "s-<up>") 'ns-prev-frame)
(global-set-key (kbd "s-<down>") 'ns-next-frame)

;; Package `default-text-scale`
(global-set-key (kbd "s-=") 'default-text-scale-increase)
(global-set-key (kbd "s--") 'default-text-scale-decrease)
(global-set-key (kbd "s-0") 'default-text-scale-reset)
;; prevent control + mouse wheel from changing text scale
(global-set-key (kbd "<C-wheel-down>") 'ignore)
(global-set-key (kbd "<C-wheel-up>") 'ignore)
(global-set-key (kbd "<C-wheel-4>") 'ignore)
(global-set-key (kbd "<C-wheel-5>") 'ignore)

;; Package `unfill`
(global-set-key (kbd "s-f") 'unfill-toggle)

;; Package `smerge`
(setq smerge-command-prefix (kbd "C-c v"))
