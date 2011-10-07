;;; pt-auto-insert.el --- templates for auto-insert.el
;; Copyright (C) 2004 Markus Grunwald

(defvar mg-auto-insert-style nil
  "*Style for auto insertion in new files or other documentation" )

;; This is the copyright holder
(if (boundp 'my-copyright-holder)
    (setq auto-insert-copyright my-copyright-holder)
  (setq auto-insert-copyright (user-full-name)))


(defun pt-make-file-header()
  "Inserts a Makefile header"
  (interactive)
  ( if (boundp 'mg-auto-insert-style )
      ( case mg-auto-insert-style
        ( (damian dafit)
          ( insert
            " # @file "(file-name-nondirectory buffer-file-name)"\n"
            " # This file may not be reproduced, disclosed or used in whole\n"
            " # or in part without the express written permission of\n"
            " # Pruftechnik Condition Monitoring GmbH.\n"
            " # \n"
            " # (c) 2000 - "( format-time-string "%Y" )" by Pruftechnik Condition Monitoring GmbH\n\n"
            )
          )
        )
    )
  )

(defun pt-c-file-header()
  "Inserts a c/c++ file header"
  ( if (boundp 'mg-auto-insert-style )
      ( case mg-auto-insert-style
        ( dafit
          ( insert
            "/** <!------------------------------------------------------------------------>\n"
            " * @file "(file-name-nondirectory buffer-file-name)"\n"
            " * This file may not be reproduced, disclosed or used in whole\n"
            " * or in part without the express written permission of\n"
            " * Pruftechnik Condition Monitoring GmbH.\n"
            " * \n"
            " * (c) 2000 - "( format-time-string "%Y" )" by Pruftechnik AG\n"
            " <!------------------------------------------------------------------------> */\n\n"
            )
          )
        ( damian
          ( insert
            "/** <!-------------------------------------------------------------------------------------------->\n"
            " * @file "(file-name-nondirectory buffer-file-name)"\n"
            " * This file may not be reproduced, disclosed or used in whole\n"
            " * or in part without the express written permission of\n"
            " * Pruftechnik Condition Monitoring GmbH.\n"
            " * \n"
            " * (c) 2000 - "( format-time-string "%Y" )" by Pruftechnik Condition Monitoring GmbH\n"
            " <!--------------------------------------------------------------------------------------------> */ \n"
            )
          )
        (otherwise (message "Meh."))
        )
    )
  )

(defun pt-c-class-header()
  "Inserts a c/c++ class header"
  ( if (boundp 'mg-auto-insert-style )
      ( case mg-auto-insert-style
        ( dafit
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
            " <!------------------------------------------------------------------------> */ \n"
            )
          ) ;; dafit
        ( damian
          ( insert
            "/** <!-------------------------------------------------------------------------------------------->\n"
            " * \n"
            " * \n"
            " * @system  Damian\n"
            " * @author   "(user-full-name) "\n"
            " * @since    "( format-time-string "%Y-%m-%d" )"\n"
            " <!--------------------------------------------------------------------------------------------> */ \n"
            )
          )
        ( otherwise
          ( insert
            "/** <!------------------------------------------------------------------------>\n"
            " * \n"
            " * \n"
            " * @author   "(user-full-name) "\n"
            " * @since    "( format-time-string "%Y-%m-%d" )"\n"
            " <!------------------------------------------------------------------------> */ \n"
            )
          )
        ) ;; case
    ( insert
            "/** <!------------------------------------------------------------------------>\n"
            " * \n"
            " <!------------------------------------------------------------------------> */ \n" )
    )
  )

(defun pt-insert-c-sections()
  "Inserts c section comments"
  (interactive)
  (insert
   "/*##############################################################################\n"
   "* INCLUDES\n"
   "*/\n"
   "#include <getopt.h>\n"
   "#include <stdio.h>\n"
   "#include <stdlib.h>\n"
   "#include <string.h>\n"
   "#include <unistd.h>\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* DEFINES\n"
   "*/\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* TYPEDEFS\n"
   "*/\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* GLOBALS\n"
   "*/\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* LOCALS\n"
   "*/\n"
   "static const char CVS_ID[] = \"$Id$\";\n"
   "static const char BUILD_TIME[] = __DATE__ \" \" __TIME__;\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* MACROS\n"
   "*/\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* FORWARD DECLARATIONS\n"
   "*/\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* GLOBAL FUNCTIONS\n"
   "*/\n"
   "\n"
   "\n"
   "/*##############################################################################\n"
   "* LOCAL FUNCTIONS\n"
   "*/\n"
   "\n"
   "\n"
   )
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
         ( pt-insert-c-sections )
         "/** **************************************************************************\n"
         " * DESCRIPTION: Output of help to cerr and exit\n"
         " * ARGUMENTS:   program name\n"
         " * RETURNS:     void\n"
         " **************************************************************************** */\n"
         "void Help( const char* szName )\n"
         "{\n"
         "    printf( \"%s [options] [filename]\\n\\n\", szName );\n"
         "    printf( \"" _ "No idea what it does. Please fill in the template!\\n\\n\");\n"
         "    printf( \"-v, --version             : sigcombine version\\n\\n\");\n"
         "    printf( \"filename                  : some filename\\n\\n\");\n"
         "    exit(1);\n"
         "    \n"
         "} // Help()\n"
         "\n"
         "\n"
         "int main( int nArgc, char* aszArgv[] )\n"
         "{\n"
         "    const uint UN_STRING_SIZE=255;\n"
         "    static struct option aoLongOptions[]=\n"
         "    {\n"
         "        // The old short options are simply mapped to long ones\n"
         "        { \"help\", no_argument, 0, 'h' },\n"
         "        { \"version\", no_argument, 0, 'v' },\n"
         "        { 0,0,0,0 } // end of list\n"
         "    };\n"
         "    char szFile[ UN_STRING_SIZE ];\n"
         "\n"
         "    int c=1;\n"
         "    while ( c != -1)\n"
         "    {\n"
         "        int nOptionIndex=0;\n"
         "        c = getopt_long (nArgc, aszArgv, \"hv\", aoLongOptions, &nOptionIndex);\n"
         "        \n"
         "        switch (c)\n"
         "        {\n"
         "            case 'v':   // version info\n"
         "                printf( \"%s revision %s\\nBuild time:%s\\n\", aszArgv[0], CVS_ID, BUILD_TIME );\n"
         "                exit( 2 );\n"
         "                break;\n"
         "            case -1:\n"
         "                break;\n"
         "            case 'h':\n"
         "            default:\n"
         "                Help( aszArgv[0] );\n"
         "        }\n"
         "    }\n"
         "\n"
         "    if ( optind < nArgc )\n"
         "    {\n"
         "         strncpy( szFile, aszArgv[ optind ], UN_STRING_SIZE );\n"
         "    }\n"
         "}\n"
         "\n"
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
         "# Let shell functions inherit ERR trap.  Same as `set -E'.\n"
         "set -o errtrace \n"
         "    # Trigger error when expanding unset variables.  Same as `set -u'.\n"
         " set -o nounset\n"
         "     #  Trap non-normal exit signals: 1/HUP, 2/INT, 3/QUIT, 15/TERM, ERR\n"
         "     #  NOTE1: - 9/KILL cannot be trapped.\n"
         "     #+        - 0/EXIT isn't trapped because:\n"
         "     #+          - with ERR trap defined, trap would be called twice on error\n"
         "     #+          - with ERR trap defined, syntax errors exit with status 0, not 2\n"
         "     #  NOTE2: Setting ERR trap does implicit `set -o errexit' or `set -e'.\n"
         " trap onexit 1 2 3 15 ERR\n"
         " \n"
         " \n"
         " #--- onexit() -----------------------------------------------------\n"
         " #  @param $1 integer  (optional) Exit status.  If not set, use `$?'\n"
         " \n"
         " function onexit() {\n"
         "     local exit_status=${1:-$?}\n"
         "     echo Exiting $0 with $exit_status\n"
         "     exit $exit_status\n"
         " }\n"
         " \n"
         " \n"
         " \n"
         " # myscript" _ "\n"
         " \n"
         " \n"
         " \n"
         "     # Allways call `onexit' at end of script\n"
         " onexit\n"
         ;; (progn (save-buffer)
         ;;        (shell-command (format "chmod +x %s"
         ;;                               (buffer-file-name))
         ;;                       )
         ;;        "")
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
         ;; (progn (save-buffer)
         ;;        (shell-command (format "chmod +x %s"
         ;;                               (buffer-file-name)))
         ;;        "")
         )

        ((org-mode . "org mode" )
         nil
         "#+OPTIONS:    H:3 num:nil toc:t \\n:nil @:t ::t |:t ^:t -:t f:t *:t TeX:t LaTeX:t skip:nil d:(HIDE) tags:not-in-toc\n"
         "#+STARTUP:    align fold nodlcheck hidestars oddeven lognotestate\n"
         "#+SEQ_TODO:   TODO(t) INPROGRESS(i) WAITING(w@) | DONE(d) CANCELED(c@)\n"
         "#+TAGS:       telephon(t) kaufen(k) brief(b)\n"
         "#+TITLE:      \n"
         "#+AUTHOR:     "(user-full-name)"\n"
         "#+EMAIL:      "(progn user-mail-address)"\n"
         "#+LANGUAGE:   en\n\n" _
         )
        ))
;; Local variables:
;; mode: emacs-lisp
;; end:
