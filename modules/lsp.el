;;; lsp.el --- LSP configuration.                    -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: lsp

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

;; There are a few available packages for LSP integration.
;; Namely, eglot and LSP mode.
;; I am going to try the former, will possibly switch to the latter if things don't work out.


;;; Code:
(leaf eglot
  :commands eglot-ensure
  :ensure t
  :custom
  ((eglot-autoshutdown . t)))


(provide 'lsp)
;;; lsp.el ends here
