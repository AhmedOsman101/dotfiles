;;; early-init.el --- Early init to kill white flash -*- lexical-binding: t; -*-
;; Set dark background BEFORE anything renders. This is what kills the flashbang.
(add-to-list 'default-frame-alist '(background-color . "#1e1e2e"))
(add-to-list 'default-frame-alist '(foreground-color . "#cdd6f4"))
(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-screen t)
;;; early-init.el ends here
