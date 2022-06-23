;;; a11y.el --- Configuration of accessibility things in Emacs.  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords: accessibility

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

;; Configuration of accessibility features within Emacs.
;; More specifically, this refers to the Emacspeak add-on, though this can be expanded upon should the need arise.
;; I had considered at one tie using speechd-el, but getting it to work properly was a bit more work than I was prepared to do at the time.

;;; Code:

(leaf emacspeak-setup
  :custom
  ((espeak-default-speech-rate . 820)
   (emacspeak-character-echo . nil)
   (emacspeak-word-echo . nil))
  :require t)

(provide 'a11y)
;;; a11y.el ends here
