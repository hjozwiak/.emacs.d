;;; communication.el --- Communicating with friends  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Hunter Jozwiak

;; Author: Hunter Jozwiak <hunter.t.joz@gmail.com>
;; Keywords:  communication

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

;;  Communication with the world with external packages.
;; In particular, Mastodon compatible places and Twitter.
;; If there are other things that I can think of further on down the line, I'll include them also.

;;; Code:
(leaf mastodon
  :ensure t)
(leaf twittering
  :ensure t)


(provide 'communication)
;;; communication.el ends here
