;;; completion.el --- Completion frameworks.         -*- lexical-binding: t; -*-

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

;; I have become a fan of Vertico, Consult and Emmbark, so we'll use them.
;; Let's give Corfu another go and actually sort things out.
;; Note that this design draws heavily on Rational Emacs for inspiration.

;;; Code:

(leaf orderless
  :ensure t
  :custom
  (
   (completion-category-overrides . '((file (styles . (basic partial-completion)))))
                                  (completion-styles . '(orderless basic))))

(leaf vertico
  :custom ((vertico-count . 20)
           (vertico-cycle . t))
  :ensure t
  :global-minor-mode vertico-mode
  :config
  (general-define-key
   :keymap vertico-map
   "C-J" 'vertico-next
   "C-k" 'vertico-previous)
  (leaf vertico-directory
    :config
    (general-define-key
     :keymap vertico-map
     "C-l" 'vertico-directory-enter
     "C-h" 'vertico-directory-up)))
(leaf marginalia
  :ensure t
  :global-minor-mode marginalia-mode)

(leaf consult
  :ensure t
  :custom
  ((completion-in-region-function . #'consult-completion-in-region))
  :config
  (general-define-key
   [remap switch-to-buffer] 'consult-buffer))

(leaf embark
  :ensure t
  :config
  (general-define-key
   [remap describe-bindings] 'embark-bindings
   "C-." 'embark-act)

  (leaf embark-consult
    :ensure t
    :hook (embark-collect-mode-hook . consult-preview-at-point-mode)))

(leaf corfu
  :ensure t
  :custom
  ((corfu-cycle . t)
   (corfu-auto . t)
   (corfu-auto-prefix . 2)
   (corfu-auto-delay . 0.0)
   (corfu-echo-documentation . 0.25))
  :global-minor-mode global-corfu-mode
  :config
  (leaf corfu-doc
    :hook corfu-mode-hook))

(leaf cape
  :ensure t
  :advice
  ((:around pcomplete-completions-at-point cape-wrap-silent)
   (:around pcomplete-completions-at-point cape-wrap-purify))
  :config
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(provide 'completion)
;;; completion.el ends here
