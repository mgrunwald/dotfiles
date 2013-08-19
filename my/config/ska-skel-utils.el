;;; ska-skel-utils.el --- Utilities for skeleton definitions
;; Copyright (C) 2001 by Stefan Kamphausen
;; Author: Stefan Kamphausen <mail@skamphausen.de>
;; Keywords: 
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
;; The short description says it all...

;;; Code:

(defun ska-skel-center-text-from-pos (&optional right-margin)
  "Insert as many spaces as needed to center the text after the
  current position nicely (with respect to the optional RIGHT-MARGIN
  which defaults to `fill-column')."
  (let* ((start-col (current-column))
		 (start-pos (point))
		 (text (buffer-substring start-pos (point-at-eol)))
		 (len (length text))
		 (rightm (or right-margin fill-column))
		 (num-spaces (/ (- rightm start-col len) 2)))
	(insert-char ?  num-spaces)
	(end-of-line)) nil)
(provide 'ska-skel-utils)

;;; ska-skel-utils.el ends here