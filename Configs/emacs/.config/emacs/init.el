;;; init.el --- Tangles config.org -*- lexical-binding: t; -*-
;; Real config lives in config.org. This loader generates + loads config.el.

;; Trust the just-tangled file without prompting (avoids a startup prompt).
(setq org-confirm-babel-evaluate nil)

(org-babel-load-file
  (expand-file-name "config.org" user-emacs-directory)
)
;;; init.el ends here
