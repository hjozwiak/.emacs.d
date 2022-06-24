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
(leaf circe
  :ensure t
  :preface
  (customize-set-variable 'circe-network-options `(
                                                   ("Libera"
                                                    :sasl-username "sektor"
                                                    :sasl-password ,(auth-source-pass-get 'secret "irc/libera.chat:6697/sektor")
                                                    :host "irc.libera.chat"
                                                    :port 6697
                                                    :use-tls t
                                                    :channels ("#archlinux" "#systemcrafters" "#sbcl" "#guix" "#emacs" "#pleroma" "#pleroma-dev"))
                                                   ("Zeronode"
                                                    :host "irc.zeronode.net"
                                                    :port 6697
                                                    :use-tls t
                                                    :sasl-username "sektor"
                                                    :sasl-password ,(auth-source-pass-get 'secret "irc/zeronode.net:6697/sektor")
                                                    :channels ("#noagenda"))
                                                   ("Stormmux"
                                                     :host "irc.stormux.org"
                                                     :port 6697
                                                     :use-tls t
                                                     :sasl-username "sektor"
                                                     :sasl-password ,(auth-source-pass-get 'secret "irc/stormux.org:6697/sektor")
                                                     :channels ("#a11y"))))
  :custom
  ((circe-default-nick . user-login-name)
   (circe-auto-join-default-type . 'after-auth)))

(leaf mastodon
  :ensure t)

(leaf twittering-mode
  :ensure t
  :custom ((twittering-oauth-invoke-browser . t)
           (twittering-allow-insecure-server-cert . t)))


(provide 'communication)
;;; communication.el ends here
