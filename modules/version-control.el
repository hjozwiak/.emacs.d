;;; version-control.el --- Git packages for Emacs.               -*- lexical-binding: t; -*-

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

(use-package magit
  :ensure t
  :general
  (mapleader
    "gg" '(magit-status :which-key "Magit status")
    "gs" '(magit-stage-file :which-key "Stage the current working file."))
  :config
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-modules 'magit-insert-stashes 'append))
(use-package magit-gitflow
    :ensure t
    :hook (magit-mode . turn-on-magit-gitflow))
(use-package git-timemachine
    :ensure t
    :general
    (mapleader
      "gt" '(git-timemachine-toggle :which-key "Toggle the time machine")))

(use-package forge
             :ensure t
             :after magit
             :general
             (mapleader
               "gf" '(forge-dispatch :which-key "Forge dispatching map.")))
(provide 'version-control)
;;; version-control.el ends here
