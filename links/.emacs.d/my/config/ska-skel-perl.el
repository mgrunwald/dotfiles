;;; ska-skel-perl.el --- Perl Magic Skeletons/Templates
;; Copyright (C) 2001 by Novel Science Int.
;; Author: Stefan Kamphausen <mail@skamphausen.de>
;; Keywords: abbrev, languages
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
;; Skeleton is really major templating system :) Here are those for
;; perl.


;;; Code:
(require 'skeleton)
(define-skeleton ska-skel-perl-file-loop
  "Insert a typical perl file loop construct."
  "Variable name: "
  "my $" str " = new IO::File(\""
  (let ((fname (read-string "Filename-expression: ")))
    (concat fname "\") or die \"Couldn't open " fname ": $!\";"))
  \n "while(my $line=<$" str ">) {"
  \n "chomp($line);"
  \n "next if $line=~m/^\\s*$/;"
  \n "next if $line=~m/^\\#/;"
  "\n"
  \n _
  \n "}" '(progn (indent-according-to-mode) nil)
  \n "$" str "->close();"
  \n)

(define-skeleton ska-skel-perl-sub
  "Insert a perl subroutine with arguments."
  "Subroutine name: "
  "sub " str " {"
  \n "my (" ("Argument name: " "$" str ", ") -2 ") = @_;"
  "\n"
  \n _
  \n "}" '(progn (indent-according-to-mode) nil)
  \n)

;; any other way to get a time format string?
(require 'time-stamp)
(define-skeleton ska-skel-perl-prog-id
  "Insert perl program identification."
  (nil)
  (insert-char ?# 60) \n
  "#" (insert-char ? 18) "PROGRAMM IDENTIFICATION" (insert-char ? 17)
  "#"\n
  (insert-char ?# 60) \n
  "my $program = \"" (file-name-nondirectory
					  (file-name-sans-extension buffer-file-name))
					  "\";"\n
  "my $filedate=\"" (time-stamp-strftime "%y-%m-%d") "\";"\n
  "my $fileversion=\"0.01\";"\n
  "my $copyright = \"Copyright (C) " (substring (current-time-string) -4)
  " by Stefan Kamphausen\";"\n
  "my $title = \"$program $fileversion, $filedate - $copyright\";"
)

(define-skeleton ska-skel-perl-options
  "Insert perl program getopt stuff."
  (nil)
  (save-excursion
	(if (re-search-backward "^use" (beginning-of-buffer) t)
		(progn (end-of-line)
			   (newline-and-indent))
	  (progn (beginning-of-buffer)
			 (while (string-match "^#" (char-to-string (char-after)))
			   (forward-line))))
	(insert "use Getopt::Long;") 
    (indent-according-to-mode)
    (insert "\n")
	nil)
  (insert-char ?# 60) \n
  "#" (insert-char ? 26) "OPTIONS" (insert-char ? 25)
  "#"\n
  (insert-char ?# 60) \n
  "my $opt_help = 0;"\n
  "my $opt_version = 0;"\n
  "my $ret = GetOptions("\n
  "\"help!\","\n
  "\"version!\""\n
  ");"\n
)

(provide 'ska-skel-perl)

;;; ska-skel-perl.el ends here