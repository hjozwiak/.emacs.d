;;; builtins.el --- Customization of builtin modules.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <sektor@tekunen>
;; Keywords: convenience

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

;;; Code:

(leaf cus-start
  :doc "Customize internal, lower level things."
  :tag "builtin" "internal"
  :custom
  ((inhibit-startup-message . t)
   (indent-tabs-mode . nil)
   (tool-bar-mode . nil)
   (menu-bar-mode . nil)
   (scroll-bar-mode . nil)
   (user-full-name . "Hunter Jozwiak")
   (user-mail-address . "hunter.t.joz@gmail.com")
   (user-login-name . "sektor")
   (use-short-answers . t)))

(leaf autorevert
  :doc "Revert buffers on disk."
  :tag "builtin"
  :custom
  ((auto-revert-interval . 0.1))
  :global-minor-mode global-auto-revert-mode)
;; The weird, one off variable that Leaf can't seem to handle.
(customize-set-variable 'auto-save-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
(leaf recentf
  :global-minor-mode recentf-mode)

(leaf savehist
  :global-minor-mode savehist-mode)
(leaf windmove)
(leaf winner)
(leaf auth-source
  :doc "Password completion from within Emacs."
  :tag "builtin" "passwords"
  :custom
  ((auth-source-cache-expiry . nil))
  :config
  (leaf auth-source-pass
    :custom
    ((auth-sources . '(("~/.authinfo.gpg" password-store))))
     :config
     (auth-source-pass-enable))

(provide 'builtins)
;;; builtins.el ends here

