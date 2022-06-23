;;; git.el --- Git packages for Emacs.               -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: git, magit, forge, gitflow

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

;; Configuration of some popular git packages for Emacs.
;; Namely, I make use of magit, forge, magit-gitflow and git-timemachine.

;;; Code:

(leaf magit
  :ensure t
  :defer-config
  (leaf forge
    :ensure t
    :config
    (mapleader
      "gf" '(forge-dispatch :which-key "Operate with forges")))
  :config
  :config
  (mapleader
    "gg" '(magit-status :which-key "Magit status")
    "gs" '(magit-stage-file :which-key "Stage the current working file."))
  (leaf magit-gitflow
    :ensure t
    :hook (magit-mode-hook . turn-on-magit-gitflow))
  (leaf git-timemachine
    :ensure t
    :config
    (mapleader
      "gt" '(git-timemachine-toggle :which-key "Toggle the time machine"))))

(provide 'git)
;;; git.el ends here
