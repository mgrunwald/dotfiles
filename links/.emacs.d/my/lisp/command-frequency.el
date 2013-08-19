;;; command-frequency.el -- track command frequencies
;; written by Ryan Yeske, 2006. Released under GPL.

; DESCRIPTION:
; this elisp code records all command calls in emacs
; and prints them in order of their frequency of use, with
; the number of times they are called.

; USAGE:
; save this file as command-frequency.el
; open it in emacs
; then type M-x eval-buffer
; then, everything you do in emacs will be recorded.
; when you want to, type M-x command-frequency-display
; and emacs will display all the commands you ever called in emacs
; in order of their frequency and their number of calls.

; PURPOSE:
; This program is useful, for gathering statistical data
; on what commands are most used in emacs
; and, in designing what default keybindings should have.

; This file is prepared by Xah Lee, 2007.
; See
; http://xahlee.org/emacs/command-frequency.html

(defvar command-frequency-table (make-hash-table :test 'equal))
(defun command-frequency-record ()
  (let* ((command this-command)
         (count (gethash command command-frequency-table)))
    (puthash command (if count (1+ count) 1)
             command-frequency-table)))
 
(defun command-frequency-display ()
  (interactive)
  (display-message-or-buffer (command-frequency) "*frequencies*"))

(defun command-frequency ()
  (with-output-to-string
    (let (l)
      (maphash (lambda (k v)
                 (setq l (cons (cons k v) l)))
               command-frequency-table)
      (mapcar (lambda (e)
                (princ (format "%d\t%s\n" (cdr e) (car e))))
              (sort l (lambda (a b) (> (cdr a) (cdr b))))))))

(add-hook 'post-command-hook 'command-frequency-record)


(defun command-frequency-write-file (file-name)
  (with-temp-file file-name
    (insert (command-frequency)))
  (with-temp-message (format "Wrote %s" file-name)))

;; (run-at-time 0 600 'command-frequency-write-file "~/public_html/command-freq.txt")
;; (cancel-function-timers 'command-frequency-write-file)


