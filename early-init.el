;; -*- lexical-binding: t; -*-
(setq inhibit-startup-message t
      toolbar-mode nil
      menu-bar-mode nil)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq gc-cons-threshold 2000000000)

(setq read-process-output-max (* 1024 1024))

(setq load-prefer-newer  t)
