;;; chb-util.el --- editing utilities          -*- Mode: Emacs-Lisp -*-
;; Time-stamp: <16-Jun-2008 12:08:57 gru>

;; Copyright (C) 2001 Claus Brunzema <mail@cbrunzema.de>
;; see http://www.cbrunzema.de

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Here are some editing utilities I find useful.

;;; Code:

;; string utils
(defun chb-string-reverse (str)
  (apply #'string (reverse (string-to-list str))))

(defun chb-string-trim-matching-head (a b)
  (let ((diff-a (copy-sequence a))
	(diff-b (copy-sequence b)))
    (while (and
	    (> (length diff-a) 0)
	    (> (length diff-b) 0)
	    (char= (elt diff-a 0) (elt diff-b 0)))
      (setq diff-a (substring diff-a 1)
	    diff-b (substring diff-b 1)))
    (list diff-a diff-b)))

(defun chb-string-diff (a b)
  (let* ((head-trim-ret-list (chb-string-trim-matching-head a b))
	 (a-head-trimmed (first head-trim-ret-list))
	 (b-head-trimmed (second head-trim-ret-list))
	 (tail-trim-ret-list (chb-string-trim-matching-head
			      (chb-string-reverse a-head-trimmed)
			      (chb-string-reverse b-head-trimmed)))
	 (a-trimmed (first tail-trim-ret-list))
	 (b-trimmed (second tail-trim-ret-list)))
    (list (chb-string-reverse a-trimmed)
	  (chb-string-reverse b-trimmed))))


;; text utils
(defvar chb-no-whitespace-re "[^ \t]")
(defvar chb-whitespace-re "[ \t\r\n]")

(defun chb-current-line-number ()
  (1+ (count-lines (point-min) (point-at-bol))))

(defun chb-current-line-string ()
  (buffer-string (point-at-bol) (point-at-eol)))

(defun chb-current-line-whitespace-only-p ()
  (not (string-match chb-no-whitespace-re (chb-current-line-string))))

(defun chb-current-line-empty ()
  (= (point-at-bol) (point-at-eol)))

(defun chb-highlight-region (start end)
  (interactive)
  (let ((ex (make-extent start end))
	(fa (make-face 'chb-highlight-line-face)))
    (set-face-background fa "LightSkyBlue2")
    (set-extent-face ex fa)
    ex))


;; delete and backspace
(defun chb-delete ()
  (interactive)
  (if (region-exists-p)
      (kill-region (region-beginning) (region-end))
    (call-interactively 'backward-or-forward-delete-char)))

(defun chb-backspace ()
  (interactive)
  (if (region-exists-p)
      (kill-region (region-beginning) (region-end))
    (call-interactively 'backward-delete-char-untabify)))


;; killing whitespace
(defun chb-kill-newline-or-tabspace-forward ()
  (interactive)
  (cond
   ((char= (following-char) ?\n)
    (delete-char 1))
   (t
    (while (or (char= (following-char) ?\ )
	       (char= (following-char) ?\t))
      (delete-char 1)))))

(defun chb-kill-newline-or-tabspace-backward ()
  (interactive)
  (cond
   ((char= (preceding-char) ?\n)
    (delete-char -1))
   (t
    (while (or (char= (preceding-char) ?\ )
	       (char= (preceding-char) ?\t))
      (delete-char -1)))))

(defun chb-just-one-space ()
  (interactive)
  (skip-chars-backward " \t\n")
  (let ((start (point)))
    (skip-chars-forward " \t\n")
    (delete-region start (point)))
  (insert " "))


;; query replace by example
(defvar chb-query-replace-by-example-line nil)
(defvar chb-query-replace-by-example-before-string "")
(defvar chb-query-replace-by-example-extent nil)

(defun chb-query-replace-by-example-post-command-hook-function () ; hey, I have dabbrev, so I can use looong names :-)
  (when (/= chb-query-replace-by-example-line
	    (chb-current-line-number))
    (chb-query-replace-by-example-cleanup)))

(defun chb-query-replace-by-example-cleanup ()
  (remove-hook 'post-command-hook
	       'chb-query-replace-by-example-post-command-hook-function)
  (setq chb-query-replace-by-example-line nil)
  (when chb-query-replace-by-example-extent
    (delete-extent chb-query-replace-by-example-extent)
    (setq chb-query-replace-by-example-extent nil)))

(defun chb-query-replace-by-example-start ()
  (if (region-exists-p)
      (progn
	(setq chb-query-replace-by-example-line nil)
	(setq chb-query-replace-by-example-extent
	      (chb-highlight-region (region-beginning)
				    (region-end)))
	(set-extent-property
	 chb-query-replace-by-example-extent
	 'start-closed t)
	(set-extent-property
	 chb-query-replace-by-example-extent
	 'end-closed t)
	(setq chb-query-replace-by-example-before-string
	      (extent-string chb-query-replace-by-example-extent)))
    
    (if (chb-current-line-empty)
	(message "query-replace-by-example is senseless on an empty line...")
      (progn
	(message "query-repace-by-example (press %s again to replace, leave line to abort)"
		 (key-description (this-command-keys)))
	(setq chb-query-replace-by-example-line (chb-current-line-number))
	(setq chb-query-replace-by-example-before-string (chb-current-line-string))
	(setq chb-query-replace-by-example-extent (chb-highlight-region (point-at-bol) (point-at-eol)))
	(add-hook 'post-command-hook
		  'chb-query-replace-by-example-post-command-hook-function)))))

(defun chb-query-replace-by-example-end ()
  (if chb-query-replace-by-example-line
      (let* ((after (chb-current-line-string))
	     (ret-list (chb-string-diff
			chb-query-replace-by-example-before-string
			after))
	     (search (first ret-list))
	     (replace (second ret-list)))
	(chb-query-replace-by-example-cleanup)
	(if (zerop (length search))
	    (message "You can't replace nothing with '%s'" replace)
	  (perform-replace search replace t nil nil)))
    (let ((after (extent-string chb-query-replace-by-example-extent)))
      (chb-query-replace-by-example-cleanup)
      (perform-replace chb-query-replace-by-example-before-string
		       after
		       t nil nil))))

(defun chb-query-replace-by-example ()
  (interactive)
  (if chb-query-replace-by-example-extent
      (chb-query-replace-by-example-end)
    (chb-query-replace-by-example-start)))


;; easy keyboard macros
(defun chb-start-kbd-macro ()
  (interactive)
  (define-key
    global-map
    (events-to-keys (this-command-keys) t)
    'chb-end-kbd-macro)
  (start-kbd-macro nil))

(defun chb-end-kbd-macro ()
  (interactive)
  (define-key
    global-map
    (events-to-keys (this-command-keys) t)
    'chb-start-kbd-macro)
  (end-kbd-macro))


;; special home and end
(defun chb-home ()
  (interactive)
  (setq zmacs-region-stays t)
  (if (not (bolp))
      (beginning-of-line)
    (if (eq this-command last-command)
	(cond
	 ((not (= (point) (window-start)))
	  (move-to-window-line 0)
	  (beginning-of-line))
	 (t
	  (goto-char (point-min)))))))

(defun chb-end ()
  (interactive)
  (setq zmacs-region-stays t)
  (if (not (eolp))
      (end-of-line)
    (if (eq this-command last-command)
	(cond
	 ((not (= (point) (save-excursion
			    (move-to-window-line -1)
			    (end-of-line)
			    (point))))
	  (move-to-window-line -1)
	  (end-of-line))
	 (t
	  (goto-char (point-max)))))))


;; page movement
(defun chb-page-down ()
  (interactive)
  (setq zmacs-region-stays t)
  (next-line
   (- (window-displayed-height) next-screen-context-lines)))

(defun chb-page-up ()
  (interactive)
  (setq zmacs-region-stays t)
  (next-line
   (- (- (window-displayed-height) next-screen-context-lines))))


;; buffer switching
(defun chb-grep (l predicate)
  (defun helper (ret-list rest)
    (if (null rest)
	(reverse ret-list)
        (progn
          (if (funcall predicate (car rest))
	      (setq ret-list (cons (car rest) ret-list)))
          (helper ret-list (cdr rest)))))
  (helper '() l))

(defun chb-buffer-should-be-skipped-p (buffer)
  ( and (string-match "\\(^[ \\*]+\\|xemacs-custom\\)" (buffer-name buffer))
        (not (string-match "^\\*gdb" (buffer-name buffer)))
        (not (string-match "^\\*info\\*" (buffer-name buffer))) )
)

(defun chb-next-buffer ()
  (interactive)
  (let ( (blist (chb-grep (buffer-list)
			 (lambda (buf)
			   (not (chb-buffer-should-be-skipped-p buf))))))
    (if blist
	(switch-to-buffer (car (reverse blist))))))

(defun chb-previous-buffer ()
  (interactive)
  (let ((blist (chb-grep (buffer-list)
                         (lambda (buf)
                           (not (chb-buffer-should-be-skipped-p buf))))))
    (when (> (length blist) 1)
      (bury-buffer)
      (while (chb-buffer-should-be-skipped-p (current-buffer))
        (bury-buffer)))))

;(require 'string)

;; automatic debug statements
(defun chb-insert-debug-output ()
  (interactive)
  (let ((max-val 0))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "DEBUG-\\([0-9]+\\)-" nil t)
	(if (> (string-to-number (match-string 1)) max-val)
	    (setq max-val (string-to-number (match-string 1))))))
    (let ((output-string (format
			  "DEBUG-%d-%s"
			  (+ 1 max-val)
			  (file-name-nondirectory (buffer-file-name)))))
      (when (and (eolp) (not (chb-current-line-whitespace-only-p)))
	(forward-line)
	(beginning-of-line))
      (cond ((eq major-mode 'c++-mode)
;	     (insert "cerr << \"")
;	     (insert output-string)
;	     (insert "\" << endl;"))
             (skeleton-insert
              '(nil
                > "# ifdef DEBUG_THIS" '(progn (indent-according-to-mode) nil) \n
                > "qDebug(\"%s::%s: " _ " \", name(), __FUNCTION__ ); " '(progn (indent-according-to-mode) nil) \n
                > "# endif" '(progn (indent-according-to-mode) nil) \n )
              ))
	    ((eq major-mode 'c-mode)
	     (insert "printf(\"")
	     (insert output-string)
	     (insert "\\n\");"))
	    ((eq major-mode 'perl-mode)
	     (insert "print \"")
	     (insert output-string)
	     (insert "\\n\";"))
	    ((eq major-mode 'scheme-mode)
	     (insert "(display \"")
	     (insert output-string)
	     (insert "\") (newline)"))
	    ((eq major-mode 'emacs-lisp-mode)
	     (insert "(display-message 'message \"")
	     (insert output-string)
	     (insert "\")"))
	    ((eq major-mode 'lisp-mode)
	     (insert "(princ \"")
	     (insert output-string)
	     (insert "\") (terpri)"))
	    ((eq major-mode 'ruby-mode)
	     (insert "puts \"")
	     (insert output-string)
	     (insert "\""))
	    ((eq major-mode 'sh-mode)
	     (insert "echo ")
	     (insert output-string)
	     (insert "\n"))
	    )
      ;(indent-according-to-mode)
      ;(insert "\n")
      (indent-according-to-mode))))


;; comment in and out
(defun chb-comment-region-or-line ()
  (interactive)
  (let ((beg 0)
	(end 0))
    (if (region-exists-p)
	(setq beg (region-beginning)
	      end (region-end))
      (save-excursion
	(beginning-of-line)
	(setq beg (point))
	(forward-line)
	(setq end (point))))
    (comment-region beg end)))

(defun chb-uncomment-region-or-line ()
  (interactive)
  (let ((beg 0)
	(end 0))
    (if (region-exists-p)
	(setq beg (region-beginning)
	      end (region-end))
      (save-excursion
	(beginning-of-line)
	(setq beg (point))
	(forward-line)
	(setq end (point))))
    (comment-region beg end -1)))

(defun chb-copy-and-comment-region-or-line ()
  (interactive)
  (let ((beg 0)
	(end 0))
    (if (region-exists-p)
	(setq beg (region-beginning)
	      end (region-end))
      (progn
	(beginning-of-line)
	(setq beg (point))
	(forward-line)
	(setq end (point))))
    (save-excursion
      (insert-string (buffer-string beg end)))
    (comment-region beg end)))


;; file creation
(defun chb-create-buffer-and-executable-file (filename mode-func)
  (find-file filename)
  (write-file filename t)
  (shell-command (concat "chmod a+x " filename))
  (funcall mode-func)
  (make-variable-buffer-local 'kill-buffer-hook)
  (add-hook 'kill-buffer-hook
	    #'(lambda () 
		(when (and (file-exists-p (buffer-file-name))
			   (zerop (elt (file-attributes (buffer-file-name)) 7))
			   (buffer-modified-p))
		  (delete-file (buffer-file-name))))
	    t t))

(require 'skeleton)

(defun make-perl (fname)
  "Create a perl buffer."
  (interactive "Fperl script name: ")
  (chb-create-buffer-and-executable-file fname #'perl-mode)
  (skeleton-insert
   '(()
     "#! /usr/bin/perl -w

# -------------------------------------------------------------------------
# - " (file-name-nondirectory fname) "
# -
# - Time-stamp: <>
# -
# - " _ "
# -
# -------------------------------------------------------------------------

use strict;
use IO::File;
use Data::Dumper;

")))

(defun make-sh (fname)
  "Create a shell script buffer."
  (interactive "Fshell script name: ")
  (chb-create-buffer-and-executable-file fname #'shell-script-mode)
  (skeleton-insert
   '(()
     "#! /bin/sh

# -------------------------------------------------------------------------
# - " (file-name-nondirectory fname) "
# -
# - Time-stamp: <>
# -
# -------------------------------------------------------------------------

")))


;; misc stuff
(defun chb-align-to-char-in-previous-line ()
  (interactive)
  (when (and (> (chb-current-line-number) 1)
             (> (current-column) 1))
    (backward-char)
    (let ((current-char (char-after))
          (target-column nil))
      (save-excursion
        (previous-line 1)
        (while (chb-current-line-whitespace-only-p)
          (previous-line 1))
        (when (search-forward (char-to-string current-char) (point-at-eol) t)
          (setq target-column (- (current-column) 1))))
      (when target-column
        (indent-to-column target-column)))
    (forward-char)))

(provide 'chb-util)
