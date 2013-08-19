;;; ska-skel-sql.el --- SQL Magic Skeletons/Templates
;; Copyright (C) 2001 by Stefan Kamphausen.
;; Author: Stefan Kamphausen <kamphausen@kandinsky.nsi-ag.de>
;; Keywords: languages, abbrev
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
;; 

;;; Code:
(require 'skeleton)

(define-skeleton ska-skel-sql-view
  "Insert a skeleton for a SQL view."
  "View Name: "
  "/*" (insert-char ?* 56) "*/" \n
  "/*  View: " str (while (< (current-column) 58)
					 (insert " "))
  "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "drop view " str ";" \n
  "create view " str " as"\n
  "select " _ \n
  "from" \n
  "where" \n
  ";"
  )

(define-skeleton ska-skel-sql-build
  "Make the current file a build skript."
  nil
  "/*" (insert-char ?* 56) "*/" \n
  "/* File: " (file-name-nondirectory buffer-file-name)
  (while (< (current-column) 58)
	(insert " "))
  "*/" \n
  "/*" (insert-char ?  56) "*/" \n
  "/* Time-stamp: <" (time-stamp-string) ">"
  (while (< (current-column) 58)
	(insert " "))
  "*/" \n
  "/*" (insert-char ?  56) "*/" \n
  "/* Copyright (C) " (substring (current-time-string) -4)
  " by " my-copyright-holder
  (while (< (current-column) 58)
	(insert " "))
  "*/" \n
  "/*" (insert-char ?  56) "*/" \n
  "/* Author " (user-full-name)
  (while (< (current-column) 58)
	(insert " "))
  "*/" \n
  "/*" (insert-char ?  56) "*/" \n
  "/* Application " (user-full-name)
  (while (< (current-column) 58)
	(insert " "))
  "*/" \n
  "/*" (insert-char ?  56) "*/" \n
  "/* ApplicationUser " (user-full-name)
  (while (< (current-column) 58)
	(insert " "))
  "*/" \n
  "/*" (insert-char ?  56) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  19) "Disable Constraints" (insert-char ?  18) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  23) "Drop Tables" (insert-char ?  22) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  22) "Create Tables" (insert-char ?  21) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  20) "Create Functions" (insert-char ?  20) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  21) "Create Packages" (insert-char ?  20) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  21) "Create Trigger" (insert-char ?  21) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  18) "Create Default Values" (insert-char ?  17) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  22) "Create Views" (insert-char ?  22) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  22) "Create Roles" (insert-char ?  22) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  22) "Schema Check" (insert-char ?  22) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "set pagesize 100" \n
  "column object_name format a30" \n
  "column object_type format a20" \n
  "column status format a20" \n
  "select object_name,object_type,status" \n
  "from user_tables" \n
  "order by logging" \n
  ";" \n
  "select index_name,index_type,tablespace_name" \n
  "from user_indexes order by" \n
  "tablespace_name" \n
  "\n\n\n"
  "/*" (insert-char ?* 56) "*/" \n
  "/*" (insert-char ?  27) "end" (insert-char ?  26) "*/" \n
  "/*" (insert-char ?* 56) "*/" \n
  "commit;" \n
  "spool off" \n
  "exit" \n
  )
(provide 'ska-skel-sql)

;;; ska-skel-sql.el ends here