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

(use-package orderless
  :ensure t
  :custom
  (completion-category-overrides '((file (styles . (basic partial-completion)))))
  (completion-styles '(orderless basic)))

(use-package vertico
  :custom (vertico-count 20)
           (vertico-cycle t)
  :ensure t
  :general
   (vertico-map
   "C-J" 'vertico-next
   "C-k" 'vertico-previous)
   :init
   (vertico-mode 1))
(use-package vertico-directory
             :after vertico
    :general
     (vertico-map
     "C-l" 'vertico-directory-enter
     "C-h" 'vertico-directory-up))
(use-package marginalia
  :ensure t
  :config (marginalia-mode))

(use-package consult
  :ensure t
  :custom
  (completion-in-region-function #'consult-completion-in-region)
  :general
   ([remap switch-to-buffer] 'consult-buffer))

(use-package embark
  :ensure t
  :general
   ([remap describe-bindings] 'embark-bindings
   "C-." 'embark-act))

(use-package embark-consult
             :ensure t
             :after (embark consult)
    :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
   (corfu-auto t)
   (corfu-auto-prefix 2)
   (corfu-auto-delay 0.0)
   (corfu-echo-documentation 0.25)
   :config
   (global-corfu-mode 1))
(use-package corfu-doc
  :ensure t
  :hook (corfu-mode . corfu-doc-mode))

(use-package cape
  :ensure t
  :config
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(provide 'completion)
;;; completion.el ends here
