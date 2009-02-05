;;; pt-auto-insert.el --- templates for auto-insert.el
;; Copyright (C) 2004 Markus Grunwald


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


                (("\\.sh$" . "Shell script")
                 nil
                 "#!/bin/bash\n"
                 "##############################################################################\n"
                 "# @file "(file-name-nondirectory buffer-file-name)"\n"
                 "# This file may not be reproduced, disclosed or used in whole\n"
                 "# or in part without the express written permission of\n"
                 "# Pruftechnik Condition Monitoring GmbH.\n"
                 "#\n"
                 "# (c) 2000 - "( format-time-string "%Y" )" by Pruftechnik AG\n"
                 "# Time-stamp: <>\n#\n"
                 "# Author: "(user-full-name) "\n#\n"
                 (progn (save-buffer)
                                (shell-command (format "chmod +x %s"
                                                                           (buffer-file-name)))
                                "")
                 )

                ((perl-mode . "Perl Program")
                 nil
                 "#! /usr/bin/perl -w\n\n"
                 "# File: " (file-name-nondirectory buffer-file-name) "\n"
                 "# Time-stamp: <>\n#\n"
                 "# Copyright (C) " (substring (current-time-string) -4)
                 " by " auto-insert-copyright "\n#\n"
                 "# Author: "(user-full-name) "\n#\n"
                 "# Description:\n# " _ "\n"
                 (progn (save-buffer)
                                (shell-command (format "chmod +x %s"
                                                                           (buffer-file-name)))
                                "")
                 )


                   ))
;; Local variables:
;; mode: emacs-lisp
;; end:
