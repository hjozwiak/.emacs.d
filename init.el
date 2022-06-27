;;; init.el --- The main loader for modules.         -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The main loader for modules.
;; There are a few things that I want loaded here:
;; * leaf, to serve as package manager.
;; * no-littering
;; * general.el, for later usage in keybindings.

;;; Code:

(customize-set-variable 'custom-file "custom.el")
(when (file-exists-p custom-file)
(load custom-file))
(customize-set-variable 'package-archives
			  '(("melpa" . "https://melpa.org/packages/")
			    ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))
  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra
      :ensure t)
    (leaf el-get
      :ensure t)
    (leaf blackout
      :ensure t)

    :config
    (leaf-keywords-init))
(leaf no-littering :ensure t)
(leaf general
  :ensure t
  :config
  (general-evil-setup)
  (general-create-definer mapleader
    :prefix "SPC"
    :global-prefix "C-SPC"
    :keymaps 'override
    :states '(normal visual emacs insert))
    (mapleader
  "b" '(:ignore t :which-key "Buffer management")
  "bb" '(switch-to-buffer :which-key "Buffer management")
  "bn" '(next-buffer :which-key "Next buffer")
  "bd" '(evil-delete-buffer :which-key "Kill a buffer")
  "bp" '(previous-buffer :which-key "Previous buffer")
  "br" '(revert-buffer :which-key "Revert the current buffer")
  "f" '(:ignore t :which-key "Files")
  "ff" '(find-file :which-key "Find a file on disk")
  "fs" '(save-buffer :which-key "Save changes")
  "F" '(:ignore t :which-key "Frames")
  "Fo" '(other-frame :which-key "Other frame")
  "g" '(:ignore t :which-key "Git operations")
  "h" '(:ignore t :which-key "Get help")
  "hd" '(:ignore t :which-key "Describe parts of Emacs")
  "hdb" '(describe-bindings :which-key "Describe the bindings that are in effect")
  "hdB" '(general-describe-keybindings :which-key "Show the bindings that General has defined.")
  "hdf" '(describe-function :which-key "Describe a function")
  "hdF" '(describe-face :which-key "Describe a face")
  "hdk" '(describe-key :which-key "Show the documentation for the function associated with key")
  "hdv" '(describe-variable :which-key "Show the docs for a variable")
  "hi" '(:ignore t :which-key "info things")
  "hii" '(info :which-key "Enter the info index")))
(add-to-list 'load-path (expand-file-name "modules/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "emacspeak/lisp/" user-emacs-directory))
(require 'builtins)
(require 'a11y)
(require 'communication)
(require 'completion)
(require 'evil-config)
(require 'git)
