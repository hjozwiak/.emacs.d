;;; init.el --- Stripped down Emacs configuration.   -*- lexical-binding: t; -*-

(set-default-coding-systems 'utf-8-unix)

(setopt use-package-expand-minimally t
        use-package-always-demand t)

(setopt user-full-name "Hunter Jozwiak"
        user-mail-address "hunter.t.joz@gmail.com")

(setopt custom-file (expand-file-name "var/custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (make-empty-file custom-file t))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(setopt package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))

(use-package evil
  :ensure t
  :init
  (setopt evil-want-integration t
          evil-want-keybinding nil
          evil-want-C-i-jump nil
          evil-respect-visual-line-mode t
          evil-want-C-h-delete t
          evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :demand t
  :config
  (general-evil-setup t)
  (general-create-definer mapleader
    :states '(normal visual insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")
  ;; Useful for local bindings
  (general-create-definer maplocal
    :states '(normal visual)
    :keymaps 'override
    :prefix ","
    :global-prefix "SPC m")
  (mapleader
    "a" '(:ignore t :which-key "Applications")
    "b" '(:ignore t :which-key "Buffer operations")
    "bb" 'switch-to-buffer
    "bd" '(kill-current-buffer :wk "Kill the current buffer")
    "br" '(revert-buffer :wk "Revert the current buffer")
    "c" '(:ignore t :which-key "Customization")
    "cc" 'customize
    "cf" 'customize-face
    "cg" 'customize-group
    "cv" 'customize-variable
    "g" '(:ignore t :which-key "Git bindings")
    ;; Bindings defined elsewhere
    "h" '(:ignore t :which-key "Help")
    "ha" 'apropos
    "hd" '(:ignore t :which-key "Describe parts of Emacs")
    "hdb" 'describe-bindings
    "hdc" 'describe-key-briefly
    "hdf" 'describe-function
    "hdF" 'describe-face
    "hdk" 'describe-key
    "hdm" 'describe-mode
    "hdM" 'describe-map
    "hds" 'describe-symbol
    "hdv" 'describe-variable
    "he" 'view-echo-area-messages
    "hi" '(:ignore t :which-key "Info")
    "hia" 'info-apropos
    "hii" 'info
    "him" 'info-display-manual
    "hl" 'view-lossage
    "o" '(:ignore t :which-key "Org")))

(setopt use-short-answers t
        use-dialog-box nil
        use-file-dialog nil)

(use-package no-littering
  :ensure t
  :demand t)

(setopt auto-revert-avoid-polling t
        auto-revert-check-vc-info t
        global-auto-revert-non-file-buffers t
        global-auto-revert-mode t)

(setopt copyright-year-ranges t)
(add-hook 'before-save-hook #'copyright-update)

(setopt savehist-mode t
        savehist-autosave-interval 30)

(use-package recentf
  :init
  (setopt recentf-mode t)
  :config
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (add-to-list 'recentf-exclude no-littering-var-directory))

(use-package windmove
  :general
  (mapleader
    "wl" 'windmove-right
    "wh" 'windmove-left
    "wk" 'windmove-up
    "wj" 'windmove-down))

(use-package winner
  :general
  (mapleader
    "wu" 'winner-undo
    "wr" 'winner-redo)
  :init
  (setopt winner-mode t))

(setopt auth-source-debug t
        auth-source-cache-expiry nil)
(when (executable-find "pass")
  (auth-source-pass-enable))

(use-package pass
  :when (executable-find "pass")
  :ensure t)

(setopt epg-pinentry-mode 'loopback)

(use-package exec-path-from-shell
  :ensure t
  :init
  (setopt exec-path-from-shell-variables '("PATH" "MANPATH" "LSP_USE_PLISTS"))
  (exec-path-from-shell-initialize))

(use-package magit
  :ensure t
  :general
  (mapleader
    "gg" 'magit
    "gs" 'magit-stage-file
    "pm" 'magit-project-status)
  :init
  (setopt magit-delete-by-moving-to-trash nil)
  :config
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-modules 'magit-insert-stashes))

(use-package forge
  :ensure t
  :after magit)

(use-package magit-gitflow
  :ensure t
  :hook ((magit-mode . turn-on-magit-gitflow)))

(use-package git-timemachine
  :ensure t)

(use-package orderless
  :demand  t
  :ensure t
  :init
  (setopt completion-styles
          '(orderless)
          completion-category-overrides
          '((file
             (styles partial-completion)))))

(defun emacspeak--vertico-directory-delete-char-speak (&optional n)
  (interactive "p")
  (unless (and (eq (char-before) ?/) (vertico-directory-up n))
    (dtk-tone-deletion)
    (emacspeak-speak-this-char (char-before))
    (delete-char (- n))))
(use-package vertico
  :ensure t
  :general
  (vertico-map
   "C-j" 'vertico-next
   "C-k" 'vertico-previous)
  :init
  (setopt vertico-count 20
          vertico-cycle t
          vertico-mode t))
(use-package vertico-directory
  :after vertico
  :hook
  (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :general
  (vertico-map
   "C-l" 'vertico-directory-enter
   "C-h" 'vertico-directory-up
   "DEL" 'vertico-directory-delete-char
   "M-DEL" 'vertico-directory-delete-word)
  :config
    (advice-add 'vertico-directory-delete-char :override #'emacspeak--vertico-directory-delete-char-speak))

(use-package consult
  :ensure t
  :general
  ([remap switch-to-buffer] 'consult-buffer
   [remap switch-to-buffer-other-window] 'consult-buffer-other-window
   [remap yank-pop] 'consult-yank-pop
   [remap goto-line] 'consult-goto-line
   [remap project-switch-to-buffer] 'consult-project-buffer
   [remap imenu] 'consult-imenu
   [remap man] 'consult-man)
  (maplocal
    "x" 'consult-mode-command))

(use-package embark
  :ensure t
  :init
  (setopt prefix-help-command #'embark-prefix-help-command)
  :general
  ([remap describe-bindings] 'embark-bindings
   "C-<menu>" 'embark-dwim
   "<menu>" 'embark-act))

(use-package embark-consult
  :ensure t
  :after embark consult
  :hook ((embark-collect-mode . consult-preview-at-point-mode)))

(use-package marginalia
  :ensure t
  :init
  (setopt marginalia-mode t)
  :general
  (minibuffer-mode-map
   "M-r" 'marginalia-cycle))

(defvar-local corfu--last-spoken-index nil "Index of the last spoken candidate.")
(defvar-local corfu--last-spoken nil "The last spoken candidate")
(defun emacspeak--speak-corfu--exhibit (&optional auto)
  "Speak the candidates as presented by Corfu."
  (when (and corfu--candidates (>= (length corfu--candidates) 0))
    (let ((to-speak nil)
          (new-cand (substring (nth corfu--index corfu--candidates) (if (>= (length corfu--candidates) 0)
                                                                        (length corfu--base)
                                                                      0))))
      (unless (equal corfu--last-spoken new-cand)
        (push new-cand to-speak)
        (when (or (equal corfu--index corfu--last-spoken-index)
                  (and (not (equal corfu--index -1))
                       (equal corfu--last-spoken-index -1)))
          (push "candidate" to-speak)))
      (when to-speak
        (dtk-speak (mapconcat #'identity to-speak " ")))
      (setq-local corfu--last-spoken-index corfu--index
                  corfu--last-spoken new-cand))))
(defun emacspeak-speak-corfu-insertion (orig &rest args)
  "Speak the currently inserted candidate."
  (let ((old-point (point)))
    (prog1
        (apply orig args)
      (emacspeak-auditory-icon 'complete)
      (emacspeak-speak-region old-point (point)))))

(use-package corfu
  :ensure t
  :general
  (corfu-map
   "C-j" 'corfu-next
   "C-k" 'corfu-previous)
  :init
  (setopt corfu-cycle t
          corfu-count 20
          corfu-auto-delay 0.0
          corfu-auto t
          global-corfu-mode  t)
  :config
  (advice-add 'corfu-insert :around #'emacspeak-speak-corfu-insertion)
  (advice-add 'corfu--exhibit :after #'emacspeak--speak-corfu--exhibit))

(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent))

(use-package yasnippet
  :ensure t
  :init
  (setopt yas-global-mode t))
(use-package yasnippet-snippets
  :after yasnippet
  :ensure t
  :config
  (yas-reload-all))

(use-package treesit
  :when (and (fboundp 'treesit-available-p) (treesit-available-p))
  :init
  (setopt major-mode-remap-alist
          '((c-mode . c-ts-mode)
            (c++-mode . c++-ts-mode)
            (csharp-mode . csharp-ts-mode)
            (conf-toml-mode . toml-ts-mode)
            (css-mode . css-ts-mode)
            (java-mode . java-ts-mode)
            (javascript-mode . js-ts-mode)
            (js-json-mode . json-ts-mode)
            (python-mode . python-ts-mode)
            (ruby-mode . ruby-ts-mode)
            (sh-mode . bash-ts-mode))))

(setopt indent-tabs-mode nil)

(use-package flymake
  :ensure t
  :hook prog-mode
  :bind
  (:map flymake-mode-map
        ("M-p" . flymake-goto-prev-error)
        ("M-n" . flymake-goto-next-error)))

(use-package eglot
  :init
  (setopt eglot-autoshutdown t)
  :hook
  ((lua-mode typescript-ts-mode js-ts-mode yaml-ts-mode python-ts-mode rust-ts-mode) . eglot-ensure))

(use-package project
  :general
  (mapleader
    "pb" 'project-switch-to-buffer
    "pd" 'project-dired
    "pe" 'project-eshell
    "pf" 'project-find-file
    "pp" 'project-switch-project
    "pr" 'project-remember-projects-under
    "ps" 'project-shell))

(setopt  xref-search-program (if (executable-find "rg") 'ripgrep 'grep)
         xref-show-xrefs-function #'consult-xref
         xref-show-definitions-function #'consult-xref)

(use-package add-node-modules-path
  :ensure t
  :hook
  ((web-mode typescript-ts-mode js-ts-mode tsx-mode) . add-node-modules-path))

(setopt speedbar-frame-parameters '((name . "speedbar")
                                    (title . "speedbar")
                                    (minibuffer . nil)
                                    (unsplittable . t)
                                    (border-height . 2)
                                    (menu-bar-lines . 0)
                                    (tool-bar-lines . 0)
                                    (left-fringe . 10))
        speedbar-update-flag t)

(use-package yaml-ts-mode
  :after treesit
  :mode "\\.ya?ml\\'")

(use-package cmake-ts-mode
  :after treesit
  :mode "\\(?:CmakeLists\\.txt\\|\\.cmake\\)\\'")

(use-package elisp-demos
  :ensure t
  :config
  (advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1))

(use-package macrostep
  :ensure t
  :general
  (maplocal
    "m" '(:ignore t :which-key "Macros")
    "me" 'macrostep-expand))

(use-package rust-ts-mode
  :after treesit
  :mode "\\.rs\\'")

(use-package cargo
  :hook (rust-ts-mode . cargo-minor-mode)
  :ensure t)

(use-package typescript-ts-mode
  :after treesit
  :mode "\\.ts\\'"
  ("\\.tsx\\'" . tsx-ts-mode))

(use-package html-ts-mode
  :after treesit
  :mode "\\.html\\'")

(use-package web-mode
  :ensure t
  :mode ".vue$" ".svelte$")

(use-package emmet-mode
  :ensure t
  :hook web-mode html-ts-mode)

(use-package sly
  :ensure t
  :hook (lisp-mode .  sly-editing-mode)
  :init
  (setopt inferior-lisp-program "sbcl"))
(use-package sly-asdf
  :ensure t
  :after sly)
(use-package sly-quicklisp
  :ensure t
  :after sly)
(use-package sly-repl-ansi-color
  :ensure t
  :after sly)

(defun conditionally-enable-lispy ()
  "Turn on lisp mode conditionally for evaluating things in the buffer."
  (when (eq this-command 'eval-expression) (lispy-mode 1)))
(use-package lispy
  :ensure t
  :hook
  ((emacs-lisp-mode scheme-mode) . lispy-mode)
  (minibuffer-setup . conditionally-enable-lispy)
  :init
  (setopt lispy-compat '(macrostep edebug)))
(use-package lispyville
  :ensure t
  :hook (lispy-mode . lispyville-mode))

(defun which-scheme ()
  "Determine the default scheme I should use given installed executables."
  (cond
   ((executable-find "guile") 'guile)
   ((executable-find "chibi-scheme") 'chibi)
   ((or (executable-find  "gosh") (executable-find "gauche")) 'gauche)
   ((executable-find "racket")  'racket)))
(use-package geiser
  :ensure t
  :init
  (setopt geiser-default-implementation (which-scheme)))

(use-package geiser-guile
  :ensure t
  :after geiser
  :when (executable-find "guile"))


(use-package geiser-chibi
  :ensure t
  :after geiser
  :when (executable-find "chibi-scheme"))

(use-package geiser-gauche
  :ensure t
  :after geiser
  :when (or (executable-find  "gosh") (executable-find "gauche")))

(use-package geiser-racket
  :ensure t
  :after geiser
  :when (executable-find "racket"))

(use-package lua-mode
  :ensure t)

(setopt gnus-use-cache t
        gnus-cache-directory (no-littering-expand-var-file-name "gnus/cache/")
        gnus-cache-active-file (expand-file-name "active" gnus-cache-directory))

(setopt gnus-asynchronous t
        gnus-use-article-prefetch t
        gnus-use-header-prefetch t)

(setopt gnus-select-method '(nnimap "gmail"
                                    (nnimap-address "imap.gmail.com")
                                    (nnimap-server-port "imaps")
                                    (nnimap-stream ssl))
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587
        smtpmail-smtp-user "hunter.t.joz@gmail.com"
        smtpmail-debug-info t
        gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setopt mml-secure-openpgp-sign-with-sender t
        message-send-mail-function #'smtpmail-send-it)

(add-hook 'message-setup-hook  #'mml-secure-message-sign)

(use-package org-mime
  :ensure t
  :hook (message-send . org-mime-htmlize))

(use-package ement
  :ensure t
  :init
  (setopt ement-save-sessions t
          ement-room-send-message-filter 'ement-room-send-org-filter))

(use-package mastodon
  :ensure t
  :general
  (mapleader
    "am" '(:ignore t :which-key "Mastodon")
    "amm" 'mastodon
    "amt" 'mastodon-toot)
  :init
  (setopt mastodon-instance-url "https://social.hunterjozwiak.com"
          mastodon-active-user "sektor"
          mastodon-auth-source-file "~/.authinfo.gpg"))

(use-package espotify
  :ensure t
  :init
  (setopt espotify-use-system-bus-p nil
          espotify-service-name "spotify"
          espotify-client-id (auth-source-pass-get "id" "apps/spotify")
          espotify-client-secret (auth-source-pass-get 'secret "apps/spotify")))

(use-package consult-spotify
  :ensure t)

(use-package empv
  :ensure t
  :init
  (setopt empv-invidious-instance "https://invid.hunterjozwiak.com/api/v1")
  :general
  (mapleader
    "ae" empv-map))

(use-package calibredb
  :ensure t
  :init
  (setopt calibredb-root-dir (expand-file-name "~/Calibre Library/")
          calibredb-db-data-dir (expand-file-name "metadata.db" calibredb-root-dir)
          calibredb-library-alist '((calibredb-db-root-dir))))

(use-package elfeed
  :ensure t
  :general
  (mapleader
    "ar" 'elfeed))

(use-package elfeed-org
  :after elfeed
  :ensure t
  :config
  (elfeed-org))

(use-package jit-spell
  :ensure t
  :init
  (setopt ispell-program-name "aspell"
          ispell-extra-args '("--sug-mode=ultra" "--keyboard=standard")
          ispell-dictionary "english"
          dictionary-server "dict.org")
  :hook text-mode prog-mode)

(use-package org
  :general
  (mapleader
    "oa" 'org-agenda
    "oc" 'org-capture
    "ol" 'org-store-link)
  :init
  (setopt org-link-descriptive t
          org-return-follows-link t
          org-hide-emphasis-markers t))

(use-package org-appear
  :ensure t
  :hook org-mode)

(use-package ednc
  :ensure t
  :init
  (setopt ednc-mode t))

(use-package emacs-gc-stats
  :ensure t
  :init
  (setopt emacs-gc-stats-remind t
          emacs-gc-stats-mode t))

(use-package emacspeak-setup
  :unless (featurep 'emacspeak)
  :load-path "emacspeak/lisp/"
  :init
  (setopt espeak-default-speech-rate 820
          emacspeak-character-echo nil
          emacspeak-word-echo nil
          emacspeak-play-emacspeak-startup-icon nil)
  :config
  (emacspeak-sounds-select-theme (expand-file-name "3d/" emacspeak-sounds-directory)))
