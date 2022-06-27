;;; utilities.el --- Utility things that I can't find another place for.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
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

;; Miscellaneous things that I find useful for Emacs.

;;; Code:

(leaf restart-emacs
  :ensure t
  :config
  (mapleader
   "qr" '(restart-emacs :which-key "Restart Emacs")))
(leaf helpful
  :ensure t
  :config
  (general-define-key
   [remap describe-function] 'helpful-callable
   [remap describe-key] 'helpful-key
   [remap describe-variable] 'helpful-variable))

(provide 'utilities)
;;; utilities.el ends here
