;; -*- Mode: Emacs-Lisp -*-
;; .vm

;; Author: Stefan Kamphausen <mail@skamphausen.de>
;; Time-stamp: <17-Jul-2002 20:37:08 markus>

;; This file is not part of XEmacs.

;; This code is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This code is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this code; see the file COPYING.  If not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.

;; not Synched up with: (X)Emacs

;; Commentary:
;; These are the settings for the VM Mailreader.
;; Much of the code in this file is derived or copied from other
;; contributors. I have tried to note the source wherever possible 

;; To use:
;; This file usually gets loaded automatically by VM. Nevertheless
;; you'll need a few more files that provide functions used in this
;; file. These are:
;; fmailutils.el, vm-multdom.el, vm-vcard.el
;; written/maintained by
;; Noah Friedman <friedman@splode.com>
;; from
;; http://www.splode.com/~friedman/software/emacs-lisp/


;; Note:
;; This file is folded using the (X)Emacs folding-mode. If you can't
;; see any real elisp code below simply right click on the triple-'{'
;; or use M-x fold-open-buffer which shows the whole buffer at once

;; Code:

;; TODO:
;; view vcard automatically, not by clicking on the grey bar

;;============================================================================
;;{{{ START-UP AND END-DOWN

;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;============================================================================
;;{{{ Start
;; my just-for-VM-instance of XEmacs is always the last to be closed
;; that overwrites the recent-file list every time.
(setq recent-files-save-list-on-exit nil)

(add-hook 'vm-mode-hook
	  (function (lambda ()
		      ;;(kampi-set-vm-keys)            ; maybe I'll need my
				                               ; own keys later
		      (mouse-avoidance-mode 'none)     ; seems to disturb
		      ;;(display-time-stop)            ; don't need this while in VM
			  (ska-vm-keys)
		      )))

;;}}}

;;----------------------------------------------------------------------------

;;{{{ End
(add-hook 'vm-quit-hook
	  (function (lambda ()
		      (bbdb-save-db)
		      (bbdb-bury-buffer))))

;;}}}

;;}}}
;;============================================================================

;;============================================================================
;;{{{ SENDING MAIL
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;============================================================================
;;{{{ Setting SMTP server (from DejaNews)

(setq send-mail-function 'smtpmail-send-it
	  message-send-mail-function 'smtpmail-send-it
	  smtpmail-default-smtp-server "smtp.yourdomain.de"
	  smtpmail-smtp-service "smtp"
	  sendmail-program "MAIL_NOT_SENT"
	  smtpmail-debug-info t
	  smtpmail-local-domain "yourdomain.de")
(load-library "smtpmail")
(defvar smtpmail-code-conv-from nil)

;;}}}

;;----------------------------------------------------------------------------
;;{{{ Reply Functions/Settings

(setq vm-reply-subject-prefix "Re: ")    ; ...
;; Authors:
;; Edwin Huffstutler <edwinh@primenet.com>
;; John Reynolds <zeek@primenet.com>
;; Claus Brunzema <mail@cbrunzema.de> (improvemens)
;; Date: 23-May-2001
(defun citation-yank-kill-sig ()
  "Nuke a .sig from cited mail and move point to a reasonable position"
  (if (save-excursion
		(search-forward-regexp (concat "^" vm-included-text-prefix)
							   (point-max) t))
	  (save-excursion
		(beginning-of-line)
		(insert "\n")
		(goto-char (point-max))
		(if (search-backward-regexp
			 (concat "^" vm-included-text-prefix)
			 1 t)
			(progn
			  (forward-line)
			  (let ((end (point)))
				(if (search-backward-regexp
					 (concat "^" vm-included-text-prefix "-- ?$")
					 1 t)
					(delete-region (point) end)))))))
  )
  
(add-hook 'vm-reply-hook
		  '(lambda ()
			 (citation-yank-kill-sig)
			 ;; move to the beginning of message
			 ;; (mail-text)
			 ;; (forward-line)
			 ))

;;}}}

;;----------------------------------------------------------------------------
;;{{{ Writing Mails
;; (add-hook 'mail-setup-hook 'spook)	  ; the other way: every mail spooks
;;}}}

;;----------------------------------------------------------------------------
;;{{{ Miscellanous Settings
(setq vm-forwarding-digest-type nil)     ; how to forward a messg 
(setq mail-signature t)                  ; always sign with .signature

;;(defvar user-full-name "Donald Hunter")
;;(setq user-mail-address "dhunter@my.domain.com")
;;}}}

;;----------------------------------------------------------------------------
;;{{{ NSCI Intern Mail Problem Fix...

;; this is just for the internal mail setup of my company where two
;; different mail systems are used

;; first the helper functions
;(defun adjust-mta ()
;  "This sets the mail transfer agent according to the recipient.
;For internal mail sendmail is used otherwise we use SMTP.
;As a side effect the user mail adress is set, too"
;  (save-excursion
;    (if (not (string-match 
;			  "\@"
;			  (vm-mail-mode-get-header-contents "To:")))
;		(setq send-mail-function 'sendmail-send-it
;			  sendmail-program "/usr/lib/sendmail"
;			  user-mail-address "local-username"
;			  )
;      (setq send-mail-function 'smtpmail-send-it
;			sendmail-program "MAIL_NOT_SENT"
;			user-mail-address "your@emailadress.com"
;			))))

;(defun delete-re-from-header (re header-name)
;  "Deletes all occurrences that match the regular expression
;re from the header-name you give."
;  (save-excursion
;    (goto-char (point-min))
;    (let ((replace-list '()))
;      (while (vm-match-header)
;		(cond ((vm-match-header header-name)
;			   (goto-char (vm-matched-header-contents-start))
;			   (cond ((re-search-forward re (vm-matched-header-contents-end) t)
;					  (setq replace-list (cons (list
;												(match-beginning 0)
;												(match-end 0))
;											   replace-list))))))
;		(goto-char (vm-matched-header-end)))
;      (mapcar (lambda (l) (delete-region (car l) (cadr l)))
;			  replace-list))))

;(defun delete-nsci-domain ()
;  (let ((host-match-re "@[-a-zA-Z0-9.]+?\\.nsi-ag\\.de"))
;    (delete-re-from-header host-match-re "To:")
;    (delete-re-from-header host-match-re "From:")
;    (delete-re-from-header host-match-re "Reply-To:")
;    (delete-re-from-header host-match-re "Return-path:")))

;;; put this into the appropriate hooks
;(add-hook 'mail-send-hook
;		  (function adjust-mta))

;(add-hook 'vm-mail-mode-hook
;		  (function (lambda ()
;					  (delete-nsci-domain)					  
;					  )))
;;}}}

;;----------------------------------------------------------------------------
;;{{{ Multiple EMail adresses
;; From: Noah Friedman <friedman@splode.com>
;; http://www.splode.com/~friedman/software/emacs-lisp/
;(require 'vm-multdom)
;(vm-multdom-install)
;(setq vm-multdom-user-addresses
;	  '(".*@yourdomain\\.de" "your@otheremailadress\\.com"))
;;          '("regexps" "matching" "each" "of" "your" "email" "addresses"))
;;
;; You may want to use regexps which match addresses for mail to specific
;; machines, e.g. "friedman@.*\\.splode\\.com\\|friedman@splode\\.com".
;;}}}

;;----------------------------------------------------------------------------
;;{{{ Mail Headers
;(setq mail-default-headers (concat
;      "X-Organization: Yourcompany, Yourcity, Yourcountry\n"
;      ))
;;}}}

;;}}}
;;============================================================================

;;============================================================================
;;{{{ RECEIVING MAIL
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;============================================================================
;;{{{ SpoolFiles (from DejaNews)
(setq vm-spool-files (list
                      ;(concat "mail.yourserver.de:110:pass:"
                      ;        (getenv "USER") ":*")
;;		      "pop.anotherserver.de:110:pass:username:password_or_star"
;;		      "munch:1100:pass:kamphausen:passwort"
		      "/var/spool/mail/username"))
;;}}}

;;----------------------------------------------------------------------------
;;{{{ Miscellanous Settings
(setq vm-folder-directory "~/Mail/")     ; Main VM Directory
(setq vm-primary-inbox "~/Mail/INBOX")  ; it's nicer than just ~/INBOX
(setq vm-mail-check-interval 300)         ; check for mail all 5mins
(setq vm-auto-get-new-mail 900)           ; auto-get that mail 15mins
;;}}}

;;}}}
;;============================================================================

;;============================================================================
;;{{{ VIEWING MESSAGES
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;============================================================================
;;{{{ Miscellanous Settings
(setq vm-preview-lines nil)              ; disable previewing (nil != 0 !!)
(setq vm-url-browser 'vm-mouse-send-url-to-netscape-new-window) ; 
;;}}}

;;----------------------------------------------------------------------------
;;{{{ V-Card Stuff

;;(require 'vm-vcard)

;;}}}

;;----------------------------------------------------------------------------
;;{{{ Real Smileys :-) And Other Fun
;; (require 'messagexmas) ; smiley requires this
(require 'smiley)         ; comes bundled with Gnus
(add-hook 'vm-select-message-hook
		  '(lambda ()
			 (smiley-region (point-min)
							(point-max))
			 ))
;; Display pictures defined in X-Headers
(setq vm-display-xfaces t)
;;}}}

;;----------------------------------------------------------------------------

;;{{{ MIME
(setq vm-honor-mime-content-disposition t)
;; maybe replace by vm-auto-displayed-mime-content-types
;; if some of them get annoying
(setq vm-auto-decode-mime-messages t)

;; Use mmencode for faster Base64 decode/encode in VM.
;; is really MUCH faster!!
;(setq vm-mime-base64-decoder-program  "mmencode"
;      vm-mime-base64-decoder-switches (list "-u")
;      vm-mime-base64-encoder-program  "mmencode"
;      vm-forwarding-digest-type "mime")

;; HTML Mail to plaintext:
(setq vm-mime-internal-content-type-exceptions '("text/html"))
(add-to-list 'vm-mime-type-converter-alist
			 ;; HTML mail alternative :
             '("text/html" "text/plain" "w3m -T \"text/html\" -dump"))

;;; setup some external viewers...
;(setq
; vm-mime-external-content-types-alist
; '(
;   ;("text/html" "netscape" )
;   ("image" "xv")
;   ("audio/wav" "rplay")
;   ("audio/midi" "timidity")
;   ("video/mpeg" "mpeg_play")
;   ("video"      "xanim")
;   ("application/postscript" "gv")
;   )
; )

;;}}}

;;}}} 
;;============================================================================

;;============================================================================
;;{{{ LOOK AND FEEL / GUI
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;----------------------------------------------------------------------------
;;{{{ Miscellanous Settings
(setq vm-inhibit-startup-message t)      ; no copyright messages and stuff

(setq vm-frame-per-composition nil)      ; Don't use multiple frames
(setq vm-frame-per-folder nil)           ; ..
(setq vm-frame-per-edit nil)             ; .. 
(setq vm-frame-per-summary nil)          ; ..

(setq vm-highlighted-header-regexp "From:\\|Subject:")
;;}}}

;;----------------------------------------------------------------------------
;;{{{ Toolbar:
;; I got my own toolbar pix.
;; You can get them from http://www.skamphausen.de/xemacs
;;(setq vm-toolbar-pixmap-directory "~/local/share/vm-new-pixmaps/")
;; configure which elements to use
(setq vm-use-toolbar
      '(getmail
		delete/undelete
		next
		previous
		autofile file
		print
		reply compose
		mime visit 
		help quit))
(fset 'vm-toolbar-getmail-command 'vm-get-new-mail)

;;}}}


;;}}}
;;============================================================================

;;============================================================================
;;{{{ DISPOSING MESSAGES
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq vm-delete-after-saving t)          ; this is not the default
(setq vm-print-command "a2ps")

;;----------------------------------------------------------------------------
;;{{{ Auto Folder
(setq vm-auto-folder-case-fold-search t) ; caseinsensitive autofiling

;;(setq vm-auto-folder-alist
;;;; code to make auto-folder default to the user name of the sender
;;   '(("From"
;;      ("<\\([^ \t\n\f@%()<>]+\\)[@%]\\([^ \t\n\f<>()]+\\)>" .
;;       (buffer-substring (match-beginning 1) (match-end 1)))
;;      ("<\\([^>]+\\)>" . 
;;       (buffer-substring (match-beginning 1) (match-end 1)))
;;      ("\\([^ \t\n\f@%()<>]+\\)\\([@%]\\([^ \t\n\f<>()]+\\)\\)?" .
;;       (buffer-substring (match-beginning 1) (match-end 1)))
;;    ))
;;)

;; Now create some autofiles for easy saving
(setq vm-auto-folder-alist
	  ;;{{{ Sender
      '(("from"
		 ;;{{{ private
		 (".*kamphaus.*" . "Perso/own")
		 ;;}}}
		 )
		;;}}}
	  ;;{{{ Recipient(s)
		("to"
		 ;;(".*xcf.*" . "Perso/gimp")
		 ;;(".*emacs.*" . "Listen/xemacs")
		 ;;(".*fltk.*" . "Listen/fltk"))
		 )
		("cc"
		 ;;(".*nautilus*" . "Listen/nautilus")
		 ;;(".*gnome-icons.*" . "Listen/gnome-icons")
		 ;;(".*emacs.*" . "Listen/xemacs")
		 ;;(".*fltk.*" . "Listen/fltk"))
		 )
		 ;;}}}
		 ))
;;}}}

;;----------------------------------------------------------------------------
;;{{{ MIME
(setq vm-mime-attachment-save-directory "~/multimedia/") ; wo Attachm. landen sollen
(setq vm-mime-attachment-auto-type-alist
	  (append '(("\\.[pl\\|pm\\|c\\|cc\\|tcl]$" . "text/plain")
				("\\.gz$" . "application/octet-stream")
				("^.*[^\\.].*$" . "text/plain"))
				vm-mime-attachment-auto-type-alist))
;;}}}

;;}}}
;;============================================================================

;;============================================================================
;;{{{ BBDB
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; since bbdb: %UB statt %F fuer Fullname aus bbdb
(setq vm-summary-format "%n %*%a %UB %-3.3m %2d %4l/%-5c %I\"%s\"\n")

;; I'd really like to know how to get rid of the very time-consuming
;; Gnus-stuff that BBDB reads at startup

;; setup bbdb
;;(require 'bbdb)
(bbdb-initialize 'vm 'message 'sendmail)
;(bbdb-insinuate-vm)
(set
 'bbdb-canonicalize-net-hook
 '(lambda (addr)
   (cond ((string-match "\\`\\([^@]+\\)@.*\\.yourlocaldomain\\.de\\'"
			addr)
	  (substring addr (match-beginning 1) (match-end 1)))
	 (t addr))))

;;}}}
;;============================================================================


;; Local variables:
;; mode: emacs-lisp
;; folded-file: t
;; end: