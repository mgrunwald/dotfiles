;;; pt-auto-insert.el --- db Prüftechnik templates for auto-insert.el
;; Copyright (C) 2004 Markus Grunwald

;; Author: Markus Grunwald <markus.grunwald@gmx.de>

;; This  is not part of XEmacs.

;;; Commentary:

;;  This file contains the company setup for the magic mode dependend
;;  insertion of templates when opening new files.

;;  To use: 
;;     (load "pt-auto-insert" nil nil nil) ;; pt auto-insert templates
;;
;;  Author:  Markus Grunwald (Software developer)
;;           ( big parts copied from Stefan Kamphausen
;;           <mail@skamphausen.de> )

;;; Code:

;; DOCs to read for more improvements than this evening:
;;     - C-h f skeleton-insert
;;     - Files:
;;       sh-script.el
;;       skeleton.el

;; We need time-stamp!
(require 'time-stamp)

(defvar user-mail-address "markus.grunwald@pruftechnik.de")

;; This is the copyright holder
(if (boundp 'my-copyright-holder)
        (setq auto-insert-copyright my-copyright-holder)
  (setq auto-insert-copyright (user-full-name)))

(defun pt-c-file-header()
  "Inserts a c/c++ file header"
  ( insert
    "/** <!------------------------------------------------------------------------>\n"
    " * @file "(file-name-nondirectory buffer-file-name)"\n"
    " * This file may not be reproduced, disclosed or used in whole\n"
    " * or in part without the express written permission of\n"
    " * Pruftechnik Condition Monitoring GmbH.\n"
    " * \n"
    " * (c) 2000 - "( format-time-string "%Y" )" by Pruftechnik AG\n"
    " <!------------------------------------------------------------------------> */\n\n" )
  )

(defun pt-c-class-header()
  "Inserts a c/c++ class header"
  ( insert
    "/** <!------------------------------------------------------------------------>\n"
    " * Description:\n"
    " * \n"
    " *********************************************************************************\n"
    " * @class    "(file-name-nondirectory (file-name-sans-extension buffer-file-name))"\n"
    " * <br>\n"
    " * System    Dafit <br>\n"
    " *********************************************************************************\n"
    " * @author   "(user-full-name) "\n"
    " * @since    "( format-time-string "%Y-%m-%d" )"\n"
    " * \n"
    " * @version  1.0 " ( format-time-string "%Y-%m-%d" ) " created by "(user-full-name) "\n"
    " <!------------------------------------------------------------------------> */ \n" )
  )

;; And here comes The List
(setq auto-insert-alist
          '(
                ;;{{{ C / C++ Header (ok, i know its ugly...)
                (("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C++ Header")
                 nil
                 ( pt-c-file-header )
                 "# ifndef "
                 (setq block_str
                       (replace-in-string
                        (upcase (concat
                                 "_"
                                 (file-name-nondirectory buffer-file-name )
                                 "_"
                                 ))
                        "\\." "_" )
                       )
                 "\n"
                 "# define " block_str "\n\n"
                 "// --- includes --- \n\n"
                 "// --- forward declarations --- \n\n"
                 "// --- namespaces --- \n\n"
                 "// --- defines --- \n\n"
                 ( pt-c-class-header )
                 "class " ( setq classname
                        (file-name-nondirectory
                         (file-name-sans-extension
                          buffer-file-name))) "\n"
                 "{\n\n"
                 "public:\n\n"
                 "signals:\n\n"
                 "public:          // Methods\n\n"
                 "public slots:\n\n"
                 "protected:       // Methods\n\n"
                 "protected slots:\n\n"
                 "private:         // Methods\n\n"
                 "private slots:\n\n"
                 "protected:       // Attributes\n\n"
                 "private:         // Attributes\n\n"
                 "}; // END class " classname "\n"
                 "\n\n# endif\n"
                 "// Local Variables:\n"
                 "// mode: c++\n"
                 "// End:\n"
                 "// EOF\n"
                 )
                ;;}}}
                ;;{{{ C Program
                (("\\.c$" . "C Program")
                 nil
                 ( pt-c-file-header )
                 "// --- includes --- \n"
                 "\#include \""
                 (file-name-nondirectory
                  (file-name-sans-extension
                   buffer-file-name))
                 ".h\"\n\n"
                 "// Local Variables:\n"
                 "// End:\n"
                 "// EOF\n"
                 )
                ;;}}}
                ;;{{{ C++ Program
                (("\\.\\([C]\\|cc\\|cpp\\)\\'" . "C++ Program")
                 nil
                 ( pt-c-file-header )
                 "// --- includes --- \n"
                 "\#include \""
                 (file-name-nondirectory
                  (file-name-sans-extension
                   buffer-file-name))
                 ".h\"\n"
                 "#include \"../general/PTDebug.h\"\n\n"
                 "/* ############################################################################\n"
                 " *  STATIC MEMBERS\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " *  CONSTANTS\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " *  CONSTRUCTORS / DESTRUCTOR\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " *  PUBLIC METHODS\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " * PROTECTED METHODS\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " *  PRIVATE METHODS\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " *  PUBLIC SLOTS\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " * PROTECTED SLOTS\n"
                 "############################################################################ */\n"
                 "\n"
                 "/* ############################################################################\n"
                 " *  PRIVATE SLOTS\n"
                 "############################################################################ */\n"
                 "\n"
                 "// Local Variables:\n"
                 "// mode: c++\n"
                 "// End:\n"
                 "// EOF\n"
                 )
                ;;}}}
                ;;{{{ Perl Program
                ((perl-mode . "Perl Program")
                 nil
                 "#! /usr/bin/perl -w\n\n"
                 "# File: " (file-name-nondirectory buffer-file-name) "\n"
                 "# Time-stamp: <>\n#\n"
                 "# Copyright (C) " (substring (current-time-string) -4)
                 " by " auto-insert-copyright "\n#\n"
                 "# Author: "(user-full-name) "\n#\n"
                 (progn (save-buffer)
                                (shell-command (format "chmod +x %s"
                                                                           (buffer-file-name)))
                                "")
                 "# Description:\n# " _ "\n"
                 )
                ;;}}}
                ;;{{{ Shell script
                ((shell-script-mode . "Shell script")
                 nil
                 "#!/bin/bash\n"
                 "##############################################################################\n"
                 "# @file "(file-name-nondirectory buffer-file-name)"\n"
                 "# This file may not be reproduced, disclosed or used in whole\n"
                 "# or in part without the express written permission of\n"
                 "# Pruftechnik Condition Monitoring GmbH.\n"
                 "# \n"
                 "# (c) 2000 - "( format-time-string "%Y" )" by Pruftechnik AG\n"
                 "# Time-stamp: <>\n#\n"
                 "# Author: "(user-full-name) "\n#\n"
                 (progn (save-buffer)
                                (shell-command (format "chmod +x %s"
                                                                           (buffer-file-name)))
                                "")
                 )
                ;;}}}
                ;;{{{ Ruby Programm
                ((ruby-mode . "Ruby Program")
                 nil
                 "#! /usr/bin/env ruby\n\n"
                 "# File: " (file-name-nondirectory buffer-file-name) "\n"
                 "# Time-stamp: <>\n#\n"
                 "# Copyright (C) " (substring (current-time-string) -4)
                 " by " auto-insert-copyright "\n#\n"
                 "# Author: "(user-full-name) "\n#\n"
                 "# Description: " _ "\n#\n\n"
                 "class " (replace-in-string
                                   (upcase-initials (file-name-nondirectory
                                                                         (file-name-sans-extension buffer-file-name)))
                                   "_"
                                   "")
                 "\n"
                 "def initialize()" (progn (ruby-indent-command) "")
                 "\nend" (progn (ruby-indent-command) "")
                 "\n end" (progn (ruby-indent-command) "")
                 )
                 ;;}}}
                ;;{{{ Emacs lisp file
                (("\\.el\\'" . "Emacs Lisp header")
                 "Short description: "
                 ";;; " (file-name-nondirectory (buffer-file-name)) " --- "
                 str
                 "\n;; Copyright (C) " (substring (current-time-string) -4) " by "
                 (user-full-name)
                 "\n;; Author: " (user-full-name) " <"
                 (user-mail-address)
;                '(if (search-backward "&" (save-excursion (beginning-of-line 1) (point)) t)
;                         (replace-match (capitalize (user-login-name)) t t))
;                '(end-of-line 1) " <" (user-login-name) ?@ (system-name)
                 ">\n;; Keywords: "
                 '(require 'finder)
                 ;;'(setq v1 (apply 'vector (mapcar 'car finder-known-keywords)))
                 '(setq v1 (mapcar (lambda (x) (list (symbol-name (car x))))
                                                   finder-known-keywords)
                                v2 (mapconcat (lambda (x) (format "%10.0s:  %s" (car x) (cdr x)))
                                                          finder-known-keywords
                                                          "\n"))
                 ((let ((minibuffer-help-form v2))
                        (completing-read "Keyword, C-h: " v1 nil t))
                  str ", ") & -2
                  (concat "\n;; This file is not part of XEmacs.\n\n"
                                  ";; This program is free software; you can "
                                  "redistribute it and/or modify it\n"
                                  ";; under the terms of the GNU General Public License as published by\n"
                                  ";; the Free Software Foundation; either version 2, or (at your option)\n"
                                  ";; any later version.\n\n"
                                  ";; This program is distributed in the hope that it will be useful, but\n"
                                  ";; WITHOUT ANY WARRANTY; without even the implied warranty of\n"
                                  ";; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU\n"
                                  ";; General Public License for more details.\n\n"
                                  ";; You should have received a copy of the GNU General Public License\n"
                                  ";; along with this program; see the file COPYING. "
                                  "If not, write to the Free\n"
                                  ";; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA\n"
                                  ";; 02111-1307, USA.\n\n\n"
                                  ";;; Commentary:\n;; ")
                  _
                  (concat "\n\n;;; Code:\n\n(provide '"
                                  (file-name-sans-extension
                                   (file-name-nondirectory
                                        (buffer-file-name)))
                                  ")\n\n;;; "
                                  (file-name-nondirectory
                                   (buffer-file-name))
                                  " ends here"))
                ;;}}}
                ;;{{{ LaTeX
                (latex-mode
                 ;; should try to offer completing read for these
                 "options, RET: "
                 "\\documentclass[" str & ?\] | -1
                 ?{ (read-string "class: ") "}\n"
                 ("package, %s: "
                  "\\usepackage[" (read-string "options, RET: ") & ?\] | -1 ?{ str "}\n")
                 _ "\n\\begin{document}\n" _
                 "\n\\end{document}")
                ;;}}}
                ;;{{{ SQL
                ((sql-mode . "SQL Standard")
                 nil
                 "/*" (insert-char ?* 56) "*/" \n
                 "/* DESCRIBE THIS FILE" _  " */"\n
                 "/*" (insert-char ?* 56) "*/" \n
                 "/* Time-stamp: <" (time-stamp-string) ">"
                 (while (< (current-column) 58)
                   (insert " "))
                 "*/"\n
                 "/*" (insert-char ?  56) "*/" \n
                 "/* Copyright (C) " (substring (current-time-string) -4)
                 " by " auto-insert-copyright
                 (while (< (current-column) 58)
                   (insert " "))
                 "*/"\n
                 "/*" (insert-char ?  56) "*/" \n
                 "/* Author: " (user-full-name)
                 (while (< (current-column) 58)
                   (insert " ")) "*/"\n
                 "/*" (insert-char ?  56) "*/" \n
                 "/*" (insert-char ?* 56) "*/" \n
                 "\n\n"
                 (insert-char ?- 60)\n
                 "--" (insert-char ? 23) "definition" (insert-char ? 23) "--"\n
                 (insert-char ?- 60)\n
                 "\n\n"
                 (insert-char ?- 60)\n
                 "--" (insert-char ? 23) "constraints" (insert-char ? 22) "--"\n
                 (insert-char ?- 60)\n
                 "\n\n"
                 (insert-char ?- 60)\n
                 "--" (insert-char ? 25) "logging" (insert-char ? 24) "--"\n
                 (insert-char ?- 60)\n
                 "\n\n"
                 (insert-char ?- 60)\n
                 "--" (insert-char ? 26) "index" (insert-char ? 25) "--"\n
                 (insert-char ?- 60)\n
                 "\n\n"
                 (insert-char ?- 60)\n
                 "--" (insert-char ? 24) "comments" (insert-char ? 24) "--"\n
                 (insert-char ?- 60)\n
                 "\n"
                   )
                ;;}}}
                   ))
;; Local variables:
;; mode: emacs-lisp
;; end:
