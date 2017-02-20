;; -*- Mode: Emacs-Lisp -*-
;; Newsserver
(setq gnus-select-method
      '(nnimap "the-grue"
	       (nnimap-address "imap.the-grue.de")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "imaps")
	       (nnimap-stream ssl)))

(setq smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
