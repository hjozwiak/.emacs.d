;;; evil.el --- Evil Configuration.                  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: evil

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

;; Configure evil mode and some related packages.


;;; Code:
(leaf undo-tree
  :ensure t
  :global-minor-mode global-undo-tree-mode)

(leaf evil
  :ensure t
  :defer-config
  (leaf evil-collection
    :ensure t
    :config
    (evil-collection-init))
  :global-minor-mode evil-mode)
