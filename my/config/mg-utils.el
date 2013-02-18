;; mg-utils.el --- Some more or less useful defuns
;; Copyright (C) 2000-2001 Stefan Kamphausen

;; Author: Markus Grunwald <markus.grunwald@gmx.de>
;; Time-stamp: <28-Sep-2012 10:47:58 gru>

;; Keywords:
;; This file is not part of XEmacs.

;; This code is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This code is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this code; see the file COPYING.  If not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.

;;; not Synched up with: (X)Emacs

;;; Commentary:

;; Here you can find all the more or less useful defuns I wrote or
;; stole (including this comment - stolen from ska...).
;; Being not a lisp hacker it may contain ugly and stupid code,
;; please tell me, if you can approve anything

;;  To use:
;;  1. (load "mg-utils" t nil)
;;  2. Most of these defuns are bound to keys in mg-*-keys.el, thus
;;  you should use them together (maybe).
;;
;;  Author:  Markus Grunwald
;;

;;; Code:

(message "Loading mg-utils")

;; We need time-stamp!
(require 'time-stamp)

(defun mg-flymake-get-project-include-dirs( base )
  ( "." "local_includes" "startscreen"
  "/usr/local/arm/2.95.3/arm-linux/include" "/usr/local/include/pt"
  "constants" "measbase" ) )

 (defun next-buffer ()
   "Switch to the next buffer in cyclic order."
   (interactive)
   (let ((buffer (current-buffer)))
     (switch-to-buffer (other-buffer buffer))
     (bury-buffer buffer)))

 (defun previous-buffer ()
   "Switch to the previous buffer in cyclic order."
   (interactive)
   (let ((list (nreverse (buffer-list)))
       found)
     (while (and (not found) list)
       (let ((buffer (car list)))
       (if (and (not (get-buffer-window buffer))
                (not (string-match "\\` " (buffer-name buffer))))
           (setq found buffer)))
       (setq list (cdr list)))
     (switch-to-buffer found)))

( defun mg-kill-entire-line()
  "Delete the entire line, no matter where point is."
  ( interactive)
  ( progn ( beginning-of-line)
          ( kill-line ) ) )

(defun mg-spaces-to-column( col )
  "Insert spaces until point is in column col"
  ( interactive "P" )
  ( while ( < (current-column) col ) (insert " " ) )
  )

(defun mg-force-qmake-project( qmake projectdir projectfile )
  ( message ( concat "Running " qmake ) )
  ( call-process "rm" nil ( get-buffer "*messages*" ) t "-fv" ( concat projectdir "/Makefile" ) )
  ( call-process qmake nil ( get-buffer "*messages*" ) t
                 ( concat projectdir "/" projectfile )
                 "-o"
                 ( concat projectdir "/Makefile" )
                 )
  )


(defun set-vxp1-arm-environment()
  "Set environment variables so that compilation for arm is possible"
  (interactive)
  (progn
    ( setenv "QTDIR" "/opt/qt/arm/qt3" )
    ( setenv "LD_LIBRARY_PATH" "/opt/qt/arm/qt3/lib" )
    ( setenv "QMAKESPEC" "qws/linux-arm-g++" )
    ( setenv "QMAKE_TARGET" "arm" )
    ( setq compile-command "NetMake -k -j11 -s --directory=${DAFIT}" )
    ( message "Environment set to vxp1 arm" )
    )
  )

(defun set-vxp2-arm-environment()
  "Set environment variables so that compilation for pxa/vxp2 is possible"
  (interactive)
  (progn
    ( setenv "QTDIR" "/opt/qt/arm/qt-embedded-free-3.3.8-patched" )
    ( setenv "LD_LIBRARY_PATH" "/opt/qt/arm/qt-embedded-free-3.3.8-patched/lib" )
    ( setenv "QMAKESPEC" "qws/linux-arm-g++-43" )
    ( setenv "QMAKE_TARGET" "arm" )
    ( setq compile-command "NetMake -k -j11 -s --directory=${VXP2}" )
    ( message "Environment set to vxp2 arm" )
    )
  )

(defun set-vxp1-debugx86-environment()
  "Set environment variables so that compilation for x86 and debugging qt is possible"
  (interactive)
  (progn
    ( setenv "QTDIR" "/opt/qt/x86/qt-x11-commercial-3.3.2-debug" )
    ( setenv "LD_LIBRARY_PATH" "/opt/qt/x86/qt-x11-commercial-3.3.2-debug/lib" )
    ( setenv "QMAKESPEC" "linux-g++-2.95" )
    ( setq compile-command "NetMake -k -j11 -s --directory=${DAFIT}" )
    ( message "Environment set to vxp1 qtdebug x86" )
    )
  )

(defun set-vxp1-x86-environment()
  "Set environment variables so that compilation for x86 is possible"
  (interactive)
  (progn
    ( setenv "QTDIR" "/opt/qt/x86/qt3" )
    ( setenv "LD_LIBRARY_PATH" "/opt/qt/x86/qt3/lib" )
    ( setenv "QMAKESPEC" "linux-g++-2.95")
    ( setenv "QMAKE_TARGET" "x86" )
    ( setq compile-command "NetMake -k -j11 -s --directory=${DAFIT}" )
    ( message "Environment set to x86" )
    )
  )


(defun set-vxp1-arm()
  "Set environment variables so that compilation for arm is possible and update Makefile"
  (interactive)
  (progn
    ( set-vxp1-arm-environment )

    (mg-force-qmake-project
     (concat ( getenv "QTDIR" )"/bin/qmake")
     ( getenv "DAFIT" )
     "zmainarm.pro" )
    ( message "Makefile set to vxp1 arm" ) )
  )

(defun set-vxp2-arm()
  "Set environment variables so that compilation for arm is possible and update Makefile"
  (interactive)
  (progn
    ( set-vxp2-arm-environment )

    (mg-force-qmake-project
     ( concat ( getenv "QTDIR" ) "/bin/qmake" )
     ( getenv "VXP2" )
     "zmainarm.pro"
     )

    ( message "Makefile set to vxp2" )
    )
  )

(defun set-vxp1-debugx86()
  "Set environment variables so that compilation for x86 and debugging qt is possible"
  (interactive)
  (progn
    (set-vxp1-debugx86-environment)

    (mg-force-qmake-project
     ( concat ( getenv "QTDIR" ) "/bin/qmake" )
     ( getenv "DAFIT" )
     "zmain.pro"
     )

    ( message "Environment set to qt debug x86" )
    )
  )

(defun set-vxp1-x86()
  "Set environment variables so that compilation for x86 is possible and update Makefile"
  (interactive)
  (progn
    ( set-vxp1-x86-environment )

    (mg-force-qmake-project
     ( concat ( getenv "QTDIR" ) "/bin/qmake" )
     ( getenv "DAFIT" )
     "zmain.pro"
     )

    ( message "Makefile set to x86" )
    )
  )

(defun set-vxp2-x86()
  "Set environment variables so that compilation for x86 is possible and update Makefile"
  (interactive)
  (progn
    ( set-vxp1-x86-environment )
    ( setq compile-command "NetMake -k -j11 -s --directory=${VXP2}" )

    (mg-force-qmake-project
     ( concat ( getenv "QTDIR" ) "/bin/qmake" )
     ( getenv "VXP2" )
     "zmain.pro"
     )

    ( message "Makefile set to x86" )
    )
  )

(defun set-pxa-kernel-environment()
  "Set environment variables so that compilation for vxp2 kernel is possible"
  (interactive)
  (progn
    (setenv "CROSS_COMPILE" "/usr/local/arm/4.3.4/usr/bin/arm-linux-" )
    (setenv "ARCH" "arm")
    (setenv "VXP2_MBUFF_DIR" "/home/gru/projects/vxp/trunk/mbuff" )
    (setenv "VXP2_KERNEL_DIR" "/home/gru/projects/vxp2/kernel/pxa-linux" )
    (setq compile-command "make" )
    ( message "Environment set to cross compile pxa" )
    )
  )


(defun mg-set-damian-icecc-arm()
  "Set environment variables so that compilation for arm with icecc is possible"
  (interactive)
  (progn
    (setenv "PATH"
            "/usr/lib/icecc/bin:/opt/damian/toolchain-arm/usr/bin:/home/gru/bin:/usr/local/bin:/usr/bin:/bin:/opt/ti/xdctools_3_22_01_21:." )
    (setenv "ICECC" "yes" )
    (setenv "ICECC_CC" "arm-none-linux-gnueabi-gcc" )
    (setenv "ICECC_CXX" "arm-none-linux-gnueabi-g++" )
    (setenv "ICECC_DEBUG" "warnings" )
    (setenv "ICECC_VERSION"
            "i686:/opt/damian/toolchain-arm/var/icecc/host-i686-target-arm-charly1.tar.gz")
    (setenv "MAKEFLAGS" "-k -j 17" )
    ;; (if (not (string-match "arm" (mg-makefile-qmake-path
    ;;                               (concat
    ;;                                (mg-ede-current-project-root-dir)
    ;;                                "Makefile") ) ) )
    ;;     (progn
    ;;       (message "Path = %s" (getenv "PATH" ) )
    ;;       (cd (mg-ede-current-project-root-dir) )
    ;;       ( call-process "which" nil ( get-buffer "*Messages*" ) t
    ;;                      "qmake" )
    ;;       ( call-process "qmake" nil ( get-buffer "*Messages*" ) t
    ;;              "-r" "CONFIG+=debug" )
    ;;       (message "yo.")
    ;;       )
    ;;   (message "bäh.")
    ;;   )

    ;; ( message "Environment set to damian-icecc-arm PATH=%s" (getenv
    ;;                                                          "PATH" )  )
    )
  )

(defun mg-set-damian-icecc-x86()
  "Set environment variables so that compilation for x86 with icecc is possible"
  (interactive)
  (progn
    (setenv "PATH"
            "/usr/lib/icecc/bin:/home/gru/bin:/usr/local/bin:/usr/bin:/bin:/opt/ti/xdctools_3_22_01_21:." )
    (setenv "ICECC" "yes" )
    (setenv "ICECC_CC" nil )
    (setenv "ICECC_CXX" nil )
    (setenv "ICECC_DEBUG" "debug" )
    (setenv "ICECC_VERSION"
            "/var/icecc/host-i686-target-i686-gru-2012-08-01-01.tar.gz")
    (setenv "MAKEFLAGS" "-k -j 17" )
    ( message "Environment set to damian-icecc-x86 PATH=%s" (getenv
                                                             "PATH" ) )
    )
  )




(defun mg-copy-position ()
  "Copy a string of the form filename:linenumber into the clipboard"
  (interactive)
  (x-store-cutbuffer (format "%s:%d"
                         (or (file-name-nondirectory buffer-file-name) "")
                         (line-number))))

;; (defalias 'mg-sync-comment (read-kbd-macro
;; "C-r /** RET C-s */ RET C-x C-x S-DEL C-k C-s ( RET C-r SPC RET <right> C-x C-x <C-insert> <home> <C-right> <C-left> C-TAB C-v C-o C <backspace> TAB <S-insert> RET <home> C-r /** RET C-s */ RET 2*<right> C-x C-x <C-insert> C-TAB <S-insert> RET C-r /** RET C-s */ RET C-x C-x C-#"))

(fset 'mg-sync-comment
   [?\C-r ?/ ?* ?* ?  ?\C-m ?\C-s ?* ?/ ?\C-m end ?\C-x ?\C-x S-delete ?\C-s ?\( ?\C-m ?\C-r ?  ?\C-m right ?\C-x ?\C-x C-insert  C-tab ?\C-v ?\C-o ?C ?P ?T tab S-insert return ?\C-r ?/ ?* ?* ?  ?\C-m ?\C-s ?* ?/ ?\C-m end ?\C-x ?\C-x C-insert C-tab home S-insert return ?\C-s ?\; ?\C-m end ?\C-r ?/ ?* ?* ?  ?\C-m ?\C-x ?\C-x ?\C-#])


(defun mg-copy-method ()
  (interactive)
  (save-excursion
    (let ((beg (search-backward "/**")))
      (c-end-of-defun)
      (copy-region-as-kill beg (point)))
      )
    )



;; (fset 'definition-to-deklaration
;;    [?\C-\M-e end ?\C-@ ?\C-\M-a S-delete backspace ?\; ?\C-r ?: ?: ?\C-m right right C-backspace ?\C-r ?/ ?* ?* ?  ?\C-m ?\C-s ?\; ?\C-x ?\C-x ?\C-#])

(defun mg-definition-to-declatation ()
 (interactive)
 (search-backward "::")
 (search-forward  "{")
 (backward-char)
 (let ( (start (point)) )
  (forward-sexp )
  (move-end-of-line nil)
  (let ( (end (point)) )
   (kill-region start end)
   )
  )
  (move-end-of-line 0)
  (insert "\;")
  (search-backward "::")
  (forward-char 2)
  (let ( (end (point)) )
   (backward-word)
   (kill-region (point) end)
   )
  )

(defalias 'mg-narrow-to-method (read-kbd-macro
"C-r /**  RET C-@ M-C-e <down> M-x narrow- to- region RET"))

;; (defalias 'mg-update-header-comment (read-kbd-macro
;; "C-s /** SPC < RET <down> <end> C-. C-r DESCRIPTION: RET 2*<C-right>3 <C-left> C-s ARGUMENTS: RET <up> <end> C-x C-x <C-insert> C-, <S-insert> C-k C-r /** SPC * RET C-s * SPC */ RET <down> <home> C-x C-x S-DEL <down> 3*<right>"))

(defun mg-update-header-comment ()
  "Update a new style function header comment from an old style comment directly above."
  (interactive)
  (search-backward "/** <")
  (move-end-of-line 2)
  (point-to-register 9)
  (search-backward "DESCRIPTION: ")
  (forward-word 2)
  (backward-word 1)
  ( let ((begin (point) ) )
    (search-forward "ARGUMENTS: ")
    (move-end-of-line 0)
    (kill-ring-save begin (point) )
    )
  (jump-to-register 9)
  (yank)
  (mg-kill-entire-line)
  (search-backward "/** *")
  (let ((begin (point)))
    (search-forward "* */")
    (move-beginning-of-line 2)
    (kill-region begin (point))
    )
  (next-line)
  (forward-char 3)
  )

(defun ispell-toggle-dictionary ()
  "toogle between German and English dictionary"
  (interactive)
  (if (string= ispell-dictionary "english")
      (progn (ispell-change-dictionary "german-old8" t)
             (message "changed ispell dictionary to german-old8"))
    (progn (ispell-change-dictionary "british" t)
           (message "changed ispell dictionary to british"))
    )
  )

;; special home
(defun mg-home ()
  (interactive)
  (setq zmacs-region-stays t)
  (if (not (bolp))
      (beginning-of-line)
    ( beginning-of-line-text ) ) )


(defun mg-split-window-auto()
  "Split the window according to its geometry"
  (interactive)
  (if (> (window-height) (/ (window-width) 2 ) ) (split-window-vertically)
  (split-window-horizontally) ) )

(defun mg-gdb-dafit ()
  "Start gdb with the actual dafit binary"
  (interactive)
  (progn (cd ( getenv "DAFIT2"  ) )
         ( gdb  "./dafit_x86.bin" ) )
  )

(defun mg-open-related-file () "" (interactive)
  (let* ((orig   (buffer-file-name))
         (base   (file-name-sans-extension orig)))
    (cond
     ((string-equal orig (concat base ".cpp")) (find-file (concat base ".h")))
     ((string-equal orig (concat base ".h" )) (find-file (concat base".cpp")))
     (t (message "Can toggle only between .cpp and .h")))))

(defun point-in-comment-or-string ()
  "returns t if point is within a comment or a string"
  ( or
    (nth 3 (parse-partial-sexp 1 (point) ) )
    (nth 4 (parse-partial-sexp 1 (point) ) )
    )
  )


(defun mg-insert-date ( prefix )
  "Inserts the actual date at point"
  ( interactive "P" )
  (if (equal prefix nil )
      (insert ( current-time-string ) )
    (insert (format-time-string "%Y-%m-%d" (current-time)) ) )
)

(defun mg-filter-variables (param-string)
  (let ((list (split-string param-string "," )))
    (delq nil
          (mapcar (lambda (param)
;;                     (string-replace-match "\\([a-zA-Z_<>:&* ]\\)* [*&]*\\([a-zA-Z_]*\\)$" param "\\2")
                    (replace-regexp-in-string "\\([a-zA-Z_<>:&* ]\\)* [*&]*\\([a-zA-Z_]*\\)$" "\\2" param )
                    )
                  list)
          )
    )
  )

(defun mg-skel-pt-vartype()
  "Returns the type prefix of a pt variable"
  ( let ( ( case-fold-search nil ) )
      ( replace-regexp-in-string
        "\\(m_\\)?\\([a-z]+\\)\\([A-Z0-9][a-zA-Z0-9]*\\)" "\\2" (current-word)
         )
    )
  )


(defun mg-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
            ((looking-at "[])}]") (forward-char) (backward-sexp 1))
            (t (self-insert-command (or arg 1)))))

(defun mg-delete-whitespace ()
  "Delete all spaces and tabs after point."
  (interactive "*")
  (delete-region (point) (progn (skip-chars-forward " \t") (point))))

;(defun mg-delete-whitespace-or-word ()
;  "Delete all spaces and tabs after point."
;  (interactive "*")
;  (cond ( (looking-at " \t")  (mg-delete-whitespace) )
;        ( t (kill-word) ) ) )

(defun mg-auctex-settings ()
  "Some local modifications to AucTeX variables."
  ;; enable usage of PDFLaTeX, Acrobat Reader and XPDF
  (add-to-list 'TeX-expand-list
	       (list "%F" 'file "pdf" t))
  ;; some more printing handling
  (mapcar (function
	    (lambda (arg)
	      (add-to-list 'TeX-printer-list arg)))
	  '(("Local" "dvips -f %s | lpr" "lpq")
	    ("hplw" "dvips -f %s | lpr -Phplw" "lpq -Phplw")
	    ("djps" "dvips -f %s | lpr -Pdjps" "lpq -Pdjps")
	    ("mini-hplw" "dvips -f %s | mini | lpr -Phplw" "lpq -Phplw")
	    ("mini-djps" "dvips -f %s | mini | lpr -Pdjps" "lpq -Pdjps")
	    ("lw") ("ps")))
  ;; some more commands
  (mapcar (function
	   (lambda (arg)
;	     (add-to-list 'TeX-command-list arg)))
             (setq TeX-command-list
		   (place-new-in-list arg TeX-command-list))))
	  (list (cons (list "PDFLaTeX" "pdflatex '\\nonstopmode\\input{%t}'"
			    'TeX-run-LaTeX nil t)
		      (list "LaTeX2e" "latex2e '\\nonstopmode\\input{%t}'"
			    'TeX-run-LaTeX nil t))
		(cons (list "Ghostview" "ghostview %f"
			    'TeX-run-background t nil)
		      (list "View" "%v " 'TeX-run-silent t nil))
		(cons (list "GV" "gv %f" 'TeX-run-background t nil)
		      (list "Ghostview" "ghostview %f"
			    'TeX-run-background t nil))
		(cons (list "Acroread" "acroread %F" 'TeX-run-background t nil)
		      (list "GV" "gv %f" 'TeX-run-background t nil))
		(cons (list "xpdf" "xpdf %F" 'TeX-run-background t nil)
		      (list "Acroread" "acroread %F"
			    'TeX-run-background t nil))
		(cons (list "Mini" "dvips %d | mini > %f"
			    'TeX-run-command t nil)
		      (list "File" "dvips %d -o %f " 'TeX-run-command t nil))))
  ;; now show a new menu
  (redefine-TeX-mode-menu))


(defun python-send-buffer-with-my-args (args)
  (interactive "sPython arguments: ")
  (let ((source-buffer (current-buffer)))
    (with-temp-buffer
      (insert "import sys; sys.argv = '''" args "'''.split()\n")
      (insert-buffer-substring source-buffer)
      (python-send-buffer))))

(defun mg-ede-current-project-root-dir ()
  "Get the root dir of the current ede project"
  (let* ((current-dir (file-name-directory
                       (or (buffer-file-name (current-buffer)) default-directory)))
         (prj (ede-current-project current-dir)))
         (ede-project-root-directory prj)))


(defun mg-makefile-qmake-path (makefile)
  "Return the current compilation target for this project"
  (interactive "sMakefile:")
  (with-current-buffer (find-file-noselect makefile )
    (save-excursion
      (goto-char (point-min))
      (let ( (split (re-search-forward "QMAKE[ \t]*=[ \t]" (point) t) ) )
        (end-of-line)
        (if split
            (buffer-substring-no-properties split (point))
          ""   ) ))))

;;(mg-makefile-qmake-path "~/projects/damian/trunk/MPC/firmware/src/Makefile" )



(message "mg-utils OK")
(provide 'mg-utils)

;; Local variables:
;; mode: emacs-lisp
;; end:
