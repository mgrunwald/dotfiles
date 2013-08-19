;;; ska-skel-ruby.el --- Ruby Magic Skeletons/Templates
;; Copyright (C) 2001 by Stefan Kamphausen
;; Author: Stefan Kamphausen <mail@skamphausen.de>
;; Keywords: languages
;; This file is not part of XEmacs.

;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING. If not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.


;;; Commentary:
;; This file provides some skeletons to make me type less in ruby mode

;;; Code:
(require 'skeleton)
(require 'ska-skel-utils)

(define-skeleton ska-skel-ruby-def
  "Inserts a new ruby function definition at point."
  "name: "
  > "def " str
  "("
  ("Argument, %s: "
   str & ", ") & -2 & ")" | -1
   \n _ "\n"
  "end" (progn (ruby-indent-command) "")
  )

(define-skeleton ska-skel-ruby-class
  "Inserts a new ruby class including the initialize function."
  "class name: "
  > "class " str \n
  > "def initialize"
  "("
  ("argument to initialize, %s: "
   str & ", ") & -2 & ")" | -1
   \n _ "\n"
   "end" (progn (ruby-indent-command) "") \n
   "end" (progn (ruby-indent-command) "")
)

(define-skeleton ska-skel-ruby-header
  "Inserts a heading comment asking for the name."
  "Header Name: "
  > (while (< (current-column) 70)
	  (insert "#"))
  \n
  > "#" str
  (progn (backward-char (length str)) nil)
  (ska-skel-center-text-from-pos)
  \n
  > (while (< (current-column) 70)
	  (insert "#"))
  \n)

(define-skeleton ska-skel-ruby-string-subst
  "Inserts a ruby string substitution pattern."
  nil
  "#{" _ "}"
  )

(provide 'ska-skel-ruby)

;;; ska-skel-ruby.el ends here