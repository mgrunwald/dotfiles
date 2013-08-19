;;; mg-skel-c.el --- Templates for C and C++ modes
;; Copyright (C) 2002 by Stefan Kamphausen
;; Author: Stefan Kamphausen <kamphausen@novelscience.com>
;; Keywords: c, tools
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
(require 'ska-skel-utils)
; xemacs (require 'string)
(require 'mg-utils)

(defun mg-skel-pt-vartype()
  "Returns the type prefix of a pt variable"
  ( let ( ( case-fold-search nil ) )
;;       ( string-replace-match
;;         "\\(m_\\)?\\([a-z]+\\)\\([A-Z0-9][a-zA-Z0-9]*\\)" (current-word)
;;         "\\2" )
      ( replace-regexp-in-string
        "\\(m_\\)?\\([a-z]+\\)\\([A-Z0-9][a-zA-Z0-9]*\\)" "\\2" (current-word) )
    )
  )

(defun mg-skel-dbg-int( var )
  "Inserts an integer debug macro for the variable var"
  ( save-excursion
    ( progn
      (search-forward ";" )
      (end-of-line)
      (insert "\n")
      (indent-according-to-mode)
      (insert ( concat "DBG_INT( LOG_DETAIL, " var " );" ) )
      )
    )
  )

(defun mg-skel-dbg-long( var )
  "Inserts a long integer debug macro for the variable var"
  ( save-excursion
    ( progn
      (search-forward ";" )
      (end-of-line)
      (insert "\n")
      (indent-according-to-mode)
      (insert ( concat "DBG_LONG( LOG_DETAIL, " var " );" ) )
      )
    )
  )

(defun mg-skel-dbg-qstr( var )
  "Inserts a qstring debug macro for the variable var"
  ( save-excursion
    ( progn
      (search-forward ";" )
      (end-of-line)
      (insert "\n")
      (indent-according-to-mode)
      (insert ( concat "DBG_STR( LOG_DETAIL, " var ".latin1() );" ) )
      )
    )
  )

(defun mg-skel-dbg-str( var )
  "Inserts a string debug macro for the variable var"
  ( save-excursion
    ( progn
      (search-forward ";" )
      (end-of-line)
      (insert "\n")
      (indent-according-to-mode)
      (insert ( concat "DBG_STR( LOG_DETAIL, " var " );" ) )
      )
    )
  )

(defun mg-skel-dbg-ptr( var )
  "Inserts a pointer debug macro for the variable var"
  ( save-excursion
    ( progn
      (search-forward ";" )
      (end-of-line)
      (insert "\n")
      (indent-according-to-mode)
      (insert ( concat "DBG_PTR( LOG_DETAIL, " var " );" ) )
      )
    )
  )

(defun mg-skel-dbg-float( var )
  "Inserts a float debug macro for the variable var"
  ( save-excursion
    ( progn
      (search-forward ";" )
      (end-of-line)
      (insert "\n")
      (indent-according-to-mode)
      (insert ( concat "DBG_FLOAT( LOG_DETAIL, " var " );" ) )
      )
    )
  )

(defun mg-skel-dbg-bool( var )
  "Inserts a float debug macro for the variable var"
  ( save-excursion
    ( progn
      (search-forward ";" )
      (end-of-line)
      (insert "\n")
      (indent-according-to-mode)
      (insert ( concat "DBG_BOOL( LOG_DETAIL, " var " );" ) )
      )
    )
  )

(defun mg-skel-dbg-free()
  "Inserts a free-form debug macro"
  (skeleton-insert
   '(  nil
       "DBG( LOG_" _ " \"\" );"  '(progn (indent-according-to-mode) nil)
       )
   )
  )

(defun mg-skel-pt-dbgvar ()
  "Inserts a debug macro for the variable at point"
  ( interactive "*" )
  ( let ( ( vartype (mg-skel-pt-vartype) )
          ( case-fold-search nil ) )
    ( cond
           (
            (string-match "osz" vartype )
            ( mg-skel-dbg-qstr (current-word) )
            )

           (
            (string-match "sz" vartype )
            ( mg-skel-dbg-str (current-word) )
            )

           (
            (string-match "x?u?[nsc]\\|by" vartype )
            ( mg-skel-dbg-int (current-word) )
            )

           (
            (string-match "x?u?l" vartype )
            ( mg-skel-dbg-long (current-word) )
            )

           (
            (string-match "u?l?[fd]" vartype )
            ( mg-skel-dbg-float (current-word) )
            )

           (
            (string-match "p.*" vartype )
            ( mg-skel-dbg-ptr (current-word) )
            )

           (
            (string-match "^b$" vartype )
            ( mg-skel-dbg-bool (current-word) )
            )

           ( t (mg-skel-dbg-free) )
           )
    )
  )

; m_bBool
; m_oszQString
; m_szString
; m_poPointer
; m_lLong
; m_nInt
; m_xlLong
; m_xnInt
; m_sShort
; m_fFloat
; m_dDouble

(defun mg-skel-c-if ()
  "Inserts an if statement (outside of a comment).\nThis should be called from an abbrev."
  (if (point-in-comment-or-string)
      (insert "if")
    (skeleton-insert
     '(  nil
         "if(" _ "  )"  '(progn (indent-according-to-mode) nil)
         \n "{"  '(progn (indent-according-to-mode) nil)
         \n
         \n "}" '(progn (indent-according-to-mode) nil)
         )
     )
    )
  )

(defun mg-skel-c-else ()
  "Inserts an else statement (outside of a comment).\nThis should be called from an abbrev."
  (if (point-in-comment-or-string)
      (insert "else")
    (skeleton-insert
     '(  nil
         "else " '(progn (indent-according-to-mode) nil)
         \n "{"  '(progn (indent-according-to-mode) nil)
         \n -1 _" " '(progn (indent-according-to-mode) nil)
         \n "}" '(progn (indent-according-to-mode) nil)
         )
     )
    )
  )

(defun mg-skel-c-for ()
  "Inserts a for statement (outside of a comment).\nThis should be called from an abbrev."
  (if (point-in-comment-or-string)
      (insert "for")
    (skeleton-insert
     '(  nil
         "for(" _ "  )"  '(progn (indent-according-to-mode) nil)
         \n "{"  '(progn (indent-according-to-mode) nil)
         \n
         \n "}" '(progn (indent-according-to-mode) nil)
         )
     )
    )
  )

(defun mg-skel-c-while ()
  "Inserts a while statement (outside of a comment).\nThis should be called from an abbrev."
  (if (point-in-comment-or-string)
      (insert "while")
    (skeleton-insert
     '(  nil
         "while("_"  )  "  '(progn (indent-according-to-mode) nil)
         \n "{"  '(progn (indent-according-to-mode) nil)
         \n
         \n "}" '(progn (indent-according-to-mode) nil)
         )
     )
    )
  )

(defun mg-skel-c-do ()
  "Inserts a do statement (outside of a comment).\nThis should be called from an abbrev."
  (if (point-in-comment-or-string)
      (insert "do")
    (skeleton-insert
     '(  nil
         "do "  '(progn (indent-according-to-mode) nil)
         \n "{"  '(progn (indent-according-to-mode) nil)
         \n
         \n "} whi" _ "le (  );" '(progn (indent-according-to-mode)
                                         nil)           )
     )
    )
  )

;(defun mg-skel-c-bool()
;  "Inserts a boolean according to coding conventions.\n This sould be called from an abbrev."
;  (if (point-in-comment-or-string)
;      (insert "bool")
;    (if (vectorp (c-at-toplevel-p))
;        ( skeleton-insert
;          '( nil "bool m_b" ) )
;      ( skeleton-insert
;        '( nil
;           > "bool b"_  ) )
;      )
;    )
;  )


(defun mg-skel-c-case ()
  "Inserts a case statement"
  ( if (point-in-comment-or-string)
      ( insert "case" )
    (skeleton-insert
     '("Mark: "
       "case "str":" '(progn (indent-according-to-mode) nil) \n
       > _ \n
       >"break;" '(progn (indent-according-to-mode) nil)
       )
     )
    )
  )

(defun mg-skel-c-switch ()
  "Inserts a switch statement"
  ( if (point-in-comment-or-string)
      ( insert "switch" )
    ( skeleton-insert
      '( "Selector: "
         > "switch( "str" )"\n
         > "{"'(progn (indent-according-to-mode) nil)\n
         > _ \n
         > "default:"'(progn (indent-according-to-mode) nil)\n
         > "break;"'(progn (indent-according-to-mode) nil)\n
         > "} // switch ( "str" )"'(progn (indent-according-to-mode) nil)\n
         )
      )
    )
  )

(defun mg-skel-c-qt-connect (SENDER SIGNAL RECEIVER SLOT)
  "Inserts a Qt connect statement"
  (interactive "sSender: \nsSignal: \nsReceiver: \nsSlot: ")
  (skeleton-insert
   '(nil
     > "connect( " SENDER ", SIGNAL( " SIGNAL " ),"'(progn (indent-according-to-mode) nil)\n
     >           RECEIVER ", SLOT  ( " SLOT   " ) );"'(progn (indent-according-to-mode) nil)\n
     )
   )
  )

(defun mg-skel-c-qt-tr ( STRING COMMENT )
  "Inserts a Qt \"tr\" string"
  (interactive "sString: \nsComment: ")
  (skeleton-insert
   '(nil
     > "tr( \"" STRING "\", \"" COMMENT " ["_"*m](gru)\" )"
     )
   )
  )

(setq hungarian-notation '( ( "int"   . "n" ) ( "short"  .  "s" ) ( "long" . "l" )
                            ( "long long" . "ll" )
                            ( "float" . "f" ) ( "double" .  "d" ) ( "ubyte" . "uby" )
                            ( "char"  . "c" ) ( "char*"  . "sz" )
                            ( "bool"  . "b" )
                            )
      )

(defun mg-skel-c-access (TYPE ATTRIBUTE )
  "Inserts a Set/Get pair of access methods for an attribute"
  (interactive "sAttribute Type: \nsAttribute Name: ")
  ( let* ( ( plain-params ( mg-filter-variables ATTRIBUTE ) )
           ( is-pointer-p ( string-match "\*" TYPE ) )
           ( hn ( cdr (assoc ( replace-regexp-in-string "\\([a-zA-Z]+\\)\\(.*\\)" "\\1" TYPE)
                            hungarian-notation ) ) )
           ( prefix
             (concat
              (if is-pointer-p "p")
              (if hn hn "o" )
               ) )
           ( parameter ( concat prefix ATTRIBUTE ) )
           ( member ( concat "m_" parameter ) )
           )
    (message "%s %s" TYPE prefix )
    ( pt-skel-c-method (concat "Set" ATTRIBUTE) ( concat TYPE " " parameter) "" )
    ( insert ( concat "Set the value of the attribute " ATTRIBUTE ) )
    ( next-line 2)
    ( end-of-line )
    ( insert ( concat "(i) Value for the attribute " ATTRIBUTE ) )
    ( next-line 2)
    ( backward-word 2 )
    ( insert "const " )
    ( forward-word 2 )
    ( backward-word 1 )
    ( mg-skel-pt-dbgvar )
    ( end-of-line )
    ( next-line 2)
    ( backward-char 3 )
    ( insert "RUNTIME" )
    ( next-line 2)
    ( insert ( concat member " = " parameter ";" ) )
    ( indent-according-to-mode)
    ( insert "\n" )
    ( next-line 1)
    ( end-of-line )
    ( backward-char 3 )
    ( insert "RUNTIME" )
    ( end-of-defun )
    ( end-of-line )
    ( newline-and-indent )
    ( newline-and-indent )

    ( pt-skel-c-method (concat "Get" ATTRIBUTE) "" TYPE )
    ( insert ( concat "Get the value of the attribute " ATTRIBUTE ) )
    ( next-line 2)
    ( end-of-line )
    ( insert ( concat "Value for the attribute " ATTRIBUTE ) )
    ( next-line 2)
    ( insert " const" )
    ( end-of-line )
    ( next-line 2)
    ( backward-char 3 )
    ( insert "RUNTIME" )
    ( next-line 1)
    ( mg-kill-entire-line )
    ( end-of-line )
    ( backward-char 3 )
    ( insert "RUNTIME" )
    ( forward-char 2 )
    ( insert member )
    ( end-of-defun )
    ( end-of-line )
    )
  )

(defun pt-insert-line ()
  ( case mg-auto-insert-style
    ( dafit
      (insert "<!-------------------------------------------------------------------------->"
              )
      )
    ( damian
      (insert "<!-------------------------------------------------------------------------------------------->"
              )
      )
    (otherwise
     (insert "<!-------------------------------------------------------------------------------------------->"
              )
     )
    )
  )

(defun pt-insert-log-block ( RETURNS )
    ( case mg-auto-insert-style
      ( dafit
        (progn
          (let ( (start (point)) )

            ( insert "DBG_START_QOBJ( LOG_ );\n" )
            (if (string= RETURNS "ErrorCode")
                ( progn (insert "DEFINE_NSUCCESS;\n\n")
                        (insert "DONE:\n")
                        (insert "DBG_RETURN( LOG_ ) nSuccess;")
                        )
              ( insert "\nDBG_RETURN( LOG_ );" )
              )
            (indent-region start (point))
            )
          )
        )
        ( damian
          (insert ""
                  )
          )
        (otherwise
         (insert ""
                 )
         )
        )
  )

(defun pt-skel-c-method (NAME PARAMETERS RETURNS )
  "Inserts a method implementation according to pt styleguide."
   (interactive "sMethod name: \nsParameter list: \nsReturns: ")
   (if (not (vectorp (c-at-toplevel-p)))
       ( let ( ( plain-params ( mg-filter-variables PARAMETERS ) )
               ( classname (file-name-nondirectory
                            (file-name-sans-extension
                             buffer-file-name))) ) ; in .cpp file
           (skeleton-insert
            '(nil                                 ; Don't prompt
              > "/** " (pt-insert-line) \n
              > "* " (progn (indent-according-to-mode) nil) _  \n
              > "*" \n
              '( if (> (length PARAMETERS) 0 )
                   ( progn
                     (mapcar (lambda (param)
                               ( progn ( insert "* @param   " param " \n" )
                                       (indent-according-to-mode )
                                       nil )
                               ) plain-params )
                     ( mg-kill-entire-line )
                     nil ) )
              > '( if ( not ( string-match RETURNS "" ) ) ( insert "* @return \n") )
              > (pt-insert-line) " */"\n
              > "" '( cond ( ( and (string= RETURNS "" ) (not(string= classname NAME)) ) ( insert "void " ) )
                           ( t ( insert RETURNS " ") ) )
              classname"::"NAME"( "PARAMETERS" )" '(progn (indent-according-to-mode) nil)\n
              >"{" '(progn (indent-according-to-mode) nil)\n
              > (pt-insert-log-block RETURNS )
              '(progn (indent-according-to-mode) nil) \n
              "} // END " NAME
              '(progn (indent-according-to-mode) nil) \n
              '(progn (indent-according-to-mode) nil) \n
              ) ) )
     ( let ( ( plain-params ( mg-filter-variables PARAMETERS ) ) )  ; in .h file
       (skeleton-insert
        '(nil                                  ; Don't prompt
              > "/** " (pt-insert-line) \n
              > "* " _ \n
              > "*" \n
              '( if (> (length PARAMETERS) 0 )
                   ( progn
                     (mapcar (lambda (param)
                               ( progn ( insert "* @param   " param " \n" )
                                       (indent-according-to-mode )
                                       nil )
                               ) plain-params )
                     ( mg-kill-entire-line )
                     nil ) )
              > '( if ( not ( string-match RETURNS "" ) ) ( insert "* @return \n") )
              > (pt-insert-line) "*/"\n
                  > "" '( cond ( ( string-match RETURNS "" ) ( insert "void" ) )
                               ( t ( insert RETURNS ) ) )
                  " " NAME"( "PARAMETERS" );" '(progn
                  (indent-according-to-mode) ) \n ))
       )))

(defun pt-skel-c-function (NAME PARAMETERS RETURNS )
  "Inserts a function implementation according to pt styleguide."
   (interactive "sFunction name: \nsParameter list: \nsReturns: ")
   (if (not (vectorp (c-at-toplevel-p)))
       ( let ( ( plain-params ( mg-filter-variables PARAMETERS ) ) ) ; in .c file
           (skeleton-insert
            '(nil                                 ; Don't prompt
              > "/** " (pt-insert-line) \n
              > "* " (progn (indent-according-to-mode) nil) _  \n
              > "*" \n
              '( if  (> (length PARAMETERS) 0 )
                   ( progn
                     (mapcar (lambda (param)
                               ( progn ( insert "* @param   " param " \n" )
                                       (indent-according-to-mode )
                                       nil )
                               ) plain-params )
                     ( mg-kill-entire-line )
                     nil ) )
              > '( if ( not ( string-match RETURNS "" ) ) ( insert "* @return \n") )
              > (pt-insert-line) " */"\n
              > "" '( cond ( (string= RETURNS "" ) ( insert "void " ) )
                             ( t ( insert RETURNS " ") ) )
              NAME"( "PARAMETERS" )" '(progn (indent-according-to-mode) nil)\n
              >"{" '(progn (indent-according-to-mode) nil)\n
              '(progn (indent-according-to-mode) nil) \n
              "} // END " NAME
              '(progn (indent-according-to-mode) nil) \n
              '(progn (indent-according-to-mode) nil) \n
              ) ) )
     ( (message "Won't work in header file!" ) )))

(define-skeleton mg-skel-c-loud-comment
  "Inserts a loud comment"
  nil
  > "// #####################################" '(progn (indent-according-to-mode) nil)\n
  > "//  " _ " " '(progn (indent-according-to-mode) nil)\n
  > "// #####################################" '(progn (indent-according-to-mode) nil)\n)

(define-skeleton mg-skel-c-middle-comment
  "Inserts a middle-loud comment"
  nil
  > "// =====================================" '(progn (indent-according-to-mode) nil)\n
  > "//  " _ " " '(progn (indent-according-to-mode) nil)\n
  > "// =====================================" '(progn (indent-according-to-mode) nil)\n)
;
; Plain variables
;
(defun pt-skel-c-short ( NAME )
  "Inserts a short according to pt styleguide."
   (interactive "sShort name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "short " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "s" NAME ";" _ \n
      )))

(defun pt-skel-c-integer ( NAME )
  "Inserts an int according to pt styleguide."
   (interactive "sInteger name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "int " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "n" NAME ";" _ \n
      )))

(defun pt-skel-c-long ( NAME )
  "Inserts a long int according to pt styleguide."
   (interactive "sLonginteger name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "long " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "l" NAME ";" _ \n
      )))

(defun pt-skel-c-bool ( NAME )
  "Inserts a bool according to pt styleguide."
   (interactive "sBool name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "bool " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "b" NAME ";" _ \n
      )))

(defun pt-skel-c-char ( NAME )
  "Inserts a character according to pt styleguide."
   (interactive "sCharacter name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "char " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "c" NAME ";" _ \n
      )))

(defun pt-skel-c-float ( NAME )
  "Inserts a float according to pt styleguide."
   (interactive "sFloat name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "float " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "f" NAME ";" _ \n
      )))

(defun pt-skel-c-double ( NAME )
  "Inserts a double according to pt styleguide."
   (interactive "sDouble name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "double " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "d" NAME ";" _ \n
      )))

(defun pt-skel-c-qstring ( NAME )
  "Inserts a QString according to pt styleguide."
   (interactive "sString name: \n")
   (skeleton-insert '(nil                                  ; Don't prompt
      > (progn (if (vectorp (c-at-toplevel-p)) (insert "//\n")))
      > "QString " (progn (if (vectorp (c-at-toplevel-p)) (insert "m_"))) "osz" NAME ";" _ \n
      )))


(provide 'mg-skel-c)

;;; mg-skel-c.el ends here
