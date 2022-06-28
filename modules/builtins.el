;;; builtins.el --- Customization of builtin modules.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: configuration

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Inclusion of the builtin parts of Emacs that my configuration will use.
;;; For now, this module is quite nebulous.
;; It will contain, in particular, all Emacs built in things that I find interesting enough  to try and configure.
;; At some point in the future, I will probably split it off into other things.
;;; Code:

(use-package emacs
  :custom
  (auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (inhibit-startup-message t)
   (indent-tabs-mode nil)
   (tool-bar-mode nil)
   (menu-bar-mode nil)
   (scroll-bar-mode nil)
   (user-full-name "Hunter Jozwiak")
   (user-mail-address "hunter.t.joz@gmail.com")
   (user-login-name "sektor")
   (use-short-answers t))

(use-package autorevert
  :custom
  (auto-revert-interval 0.1)
:config
    (global-auto-revert-mode))


(use-package recentf
  :config (recentf-mode))

(use-package savehist
  :config (savehist-mode))

(use-package windmove)

(use-package winner)
(use-package auth-source
  :custom
  (auth-source-cache-expiry nil))
(use-package auth-source-pass
  :custom
  (auth-sources '("~/.authinfo.gpg" password-store))
  :config
  (auth-source-pass-enable))

(provide 'builtins)
;;; builtins.el ends here

