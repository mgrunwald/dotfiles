;; ska-utils.el --- Some more or less useful defuns
;; Copyright (C) 2000-2001 Stefan Kamphausen

;; Author: Stefan Kamphausen <mail@skamphausen.de>
;; Time-stamp: <17-Sep-2002 13:33:37 gru>

;; Keywords: 
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

;;; not Synched up with: (X)Emacs

;;; Commentary:

;; Here you can find all the more or less useful defuns I wrote or
;; stole. Being not a lisp hacker I may contain ugly and stupid code,  
;; please tell me, if you can approve anything

;;  To use:
;;  1. (load "ska-utils" t nil)
;;  2. Most of these defuns are binded to keys in ska-*-keys.el, thus
;;  you should use them together (maybe).
;;
;;  Author:  Stefan Kamphausen
;;           http://www.skamphausen.de

;;; Code:

(message "Loading ska-utils")
;; 
;; suggested key-bindings:
;;(global-set-key '(control \.) 'point-to-register-1)
;;(global-set-key '(control \,) 'jump-to-register-1)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. Use ska-jump-to-register
to jump back to the stored position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
	(jump-to-register 8)
	(set-register 8 tmp)))
;;----------------------------------------------------------------------------

;; f4 fuer kill-buffer ist ja nett, aber oft brauche ich auch
;; killbuffer und schliess window (auf shift f4...)
(defun ska-kill-this-window ()
  "Kill buffer in current window and delete window after that."
  (interactive)
  (kill-this-buffer)
  (delete-window))

;; aehnliches fuer switch-to-buffer:
;; switch to buffer und kill this window
;; key-Vorschlag C-x B
(defun ska-switch-to-buffer-whole-window (BUFNAME)
  "Switch to chosen buffer and make that the only window."
  (interactive "BSwitch to buffer in whole window: ")
  (switch-to-buffer BUFNAME)
  (delete-other-windows))


;(defun ska-previous-buffer ()
;  "Hmm, to be frank, this is just the same as bury-buffer.
;Used to wander through the buffer stack with the keyboard."
;  (interactive)
;  (bury-buffer))

;(defun ska-next-buffer-1 ()
;  "Cycle to the next buffer with keyboard. Skips all buffers
;whose name begins with a space or a star"
;  (interactive)
;  (switch-to-buffer
;   (car (reverse
;	 (chb-grep (buffer-list)
;		   (lambda (bn) (not (string-match "^[ \\*]+" (buffer-name
;													   bn)))))))))
;(defun ska-next-buffer-2 ()
;  "Cycle to the next buffer with keyboard. Skips all buffers
;whose name begins with a space"
;  (interactive)
;  (switch-to-buffer
;   (car (reverse
;	 (chb-grep (buffer-list)
;		   (lambda (bn) (not (string-match "^ ?" (buffer-name
;													   bn)))))))))

;; The old version
;(defun ska-next-buffer ()
;  "Cycle to the next buffer with keyboard."
;  (interactive)
;  (let* ((bufs (buffer-list))
;	   (entry (1- (length bufs)))
;	   val)
;    (while (not (setq val (nth entry bufs)
;		      val (and (/= (aref (buffer-name val) 0)
;				   ? )
;			       val)))
;      (setq entry (1- entry)))
;      (switch-to-buffer val)))

;;----------------------------------------------------------------------------
(defun ska-fit-fill-column-to-frame () 
  "Falls (window-width) < fill-column+3, fill-column verkleinern." 
  (interactive) 
  (if (< (frame-width) 79) 
      ( setq fill-column (- (frame-width) 3)) 
    ) 
  )

(defun ska-insert-exec-text (command)
  "Insert the output of an executable programm at the 
current cursorpostion."
  (interactive "sEnter command-string:  \n")
  (insert (exec-to-string command)))

;; how many times have I typed a whole path into a buffer w/o TAB??
(defun ska-insert-path (pathname)
  (interactive "FInsert Path: ")
  (insert pathname))

(defun ska-mail-insert-answer-gap ()
  "Insert a nicely formatted gap when answering an email."
  (interactive)
  (insert-char ?\n 2)
  (save-excursion
	(insert-char ?\n 2)
	(insert " >")
	(when (not (looking-at " ")) (insert " ")))
)

;; The fantastic speedbar definetly needs a TOGGLE
(defun ska-speedbar-toggle-expand ()
  (interactive)
  (beginning-of-line)
  ;; if we're on a [+] line we can simply expand
  (if (re-search-forward ":\\s-*.\\+."
						 (save-excursion (end-of-line) (point))
						 t)
	  (speedbar-expand-line)
	;; if starts with "\\s>", we're in a expanded list
	;; else
	;; go back to the last line with [-] at the beginning
	(progn
	  (end-of-line)
	  ;; correction by CHB
	  (re-search-backward ":\\s-*.-." (point-min) t)
	  (speedbar-contract-line))
	))

(message "ska-utils OK")
(provide 'ska-utils)

;; Local variables:
;; mode: emacs-lisp
;; end:
