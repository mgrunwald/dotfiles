;;; ska-local-keys.el --- my own major mode dependend key-bindings
;; Copyright (C) 2000-2001 Stefan Kamphausen

;; Author: Stefan Kamphausen <mail@skamphausen.de>
;; Time-stamp: <28-Jul-2008 11:17:16 gru>

;; Keywords: 
;; This file is not part of XEmacs.

;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be userful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING. If not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.


;;; Commentary:
;; In this file we define defuns for loading in each mode specific
;; hook. Each defun follows the naming convention
;; ska-<major-mode-name>-keys
;; Note that skeleton template key-bindings will be loaded from this
;; file, too.

;;; To use:
;;  1. (load "ska-local-keys" t nil)
;;           reads this file
;;  2. For each mode you need to call the appropriate defun in the
;;     hook, e.g:
;; (add-hook 'c-mode-hook
;; 		  '(lambda ()
;; 			 ;; my keybindings
;; 			 (ska-c-mode-keys c-mode-map)
;;			 ))

;;; Code:
;; My own prefix for globally available commands: C-b
;; (just like C-x and C-c for xemacs' defaults)
(global-unset-key '[(control b)])

;; Newsgroup says it would be best to use a different modifier (Hyper,
;; Super) as personal prefix.

;; Maybe this is better:?
;(define-prefix-command 'user-mode-specific-prefix t)
;(defvar user-mode-specific-map (symbol-function
;'user-mode-specific-prefix) "\
;The default keymap for all mode specific actions defined by the
;user.")
;(define-key global-map '[(control b)] 'user-mode-specific-prefix)

;; see also : http://xahlee.org/emacs/keyboard_shortcuts.html

;;{{{ Programming Keys For All Modes
;;----------------------------------
(defun ska-coding-keys (map)
  "Sets the key bindings which shall be available in all programming
languages. Argument MAP is the local keymap (e.g. cperl-mode-map)."
  (define-key map '[(return)]                 'newline-and-indent)
;  (define-key map '[(control b) (d)]          'chb-insert-debug-output)
;;   (define-key map '[(control b) (\;)]         'chb-comment-region-or-line)
;;   (define-key map '[(control b) (\:)]         'chb-uncomment-region-or-line)
;;   (define-key map '[(control b) (c)]          'chb-copy-and-comment-region-or-line) 
  (define-key map '[(control \#)]             'indent-region )
  (define-key map '[(control h) (m)]          'woman)
  (define-key map '[(control b) (v)]          'svn-status)  
  )
;;}}}


;;{{{ Speedbar
;;------------
(defun ska-speedbar-keys ( map )
  "Set keybindings in major navigation tool Speedbar."
  (define-key map '[(g)]    'speedbar-update-contents)
  (define-key map '[(kbd "SPC")]    'ska-speedbar-toggle-expand)
  )
;;}}}



;;{{{ C and C++ Mode

;;------------------
;; This defun is slightly different from the others since it works for
;; two major modes. Therefore the map to use is passed
(require 'mg-skel-c)
(require 'klaralv)
(defun ska-c-common-mode-keys (map)
  "Set my personal keys for C and C++.
Argument MAP is c-mode-map or c++-mode-map."
  (define-key map  [S-iso-lefttab]            'ff-find-other-file)
  (define-key map '[(control b) (control b)]  'compile)
  (define-key map '[(f9)]                     'compile)
  (define-key map '[(control f9)]             'kill-compilation)
  (define-key map '[(control b) (control c)]  'mg-copy-method)
  (define-key map '[(control b) (control l)]  'add-change-log-entry)
  (define-key map '[(control b) (control n)]  'mg-narrow-to-method)
  (define-key map '[(control b) (control q)]  'kdab-lookup-qt-documentation)
  (define-key map '[(control b) (d)]          'mg-skel-pt-dbgvar)
  (define-key map '[(control j)]              'c-indent-new-comment-line)
  (define-key map '[(meta y)]                 'imenu)
  (define-key map '[(control v) (control l)]  'goto-line) 

;  ;; XRef
;  (define-key map [(control v) (r)]  'xref-refactor)
;;;  (define-key map [(shift space)]    'xref-completion)
;  (define-key map [(control v) (f7)] 'xref-delete-window)
;  (define-key map [(control v) (f6)] 'xref-push-and-goto-definition)
;  (define-key map [(control v) (control f6)] 'xref-browse-symbol)
;  (define-key map [(control v) (f5)] 'xref-pop-and-return)
;  (define-key map [(control v) (control f5)] 'xref-re-push)
;  (define-key map [(control v) (f4)] 'xref-next-reference)
;  (define-key map [(control v) (control f4)] 'xref-alternative-next-reference)
;  (define-key map [(control v) (f3)] 'xref-previous-reference)
;  (define-key map [(control v) (control f3)] 'xref-alternative-previous-reference)
  
  ;; Skeletons
;;   (define-key map '[(control i) (h)]  'pt-skel-c-short)
;;   (define-key map '[(control i) (i)]  'pt-skel-c-integer)
;;   (define-key map '[(control i) (l)]  'pt-skel-c-long)
;;   (define-key map '[(control i) (b)]  'pt-skel-c-bool)
;;   (define-key map '[(control i) (c)]  'pt-skel-c-char)
;;   (define-key map '[(control i) (f)]  'pt-skel-c-float)
;;   (define-key map '[(control i) (d)]  'pt-skel-c-double)
   (define-key map '[(control n) (s)]  'pt-skel-c-qstring)
   (define-key map '[(control n) (m)]  'pt-skel-c-method)
   (define-key map '[(control n) (o)]  'mg-skel-c-loud-comment)
   (define-key map '[(control n) (e)]  'mg-skel-c-middle-comment)
   (define-key map '[(control n) (q) (c)]  'mg-skel-c-qt-connect)
   (define-key map '[(control n) (q) (h)]  'kdab-insert-header)
   (define-key map '[(control n) (q) (f)]  'kdab-insert-forward-decl)
   (define-key map '[(control n) (q) (t)]  'mg-skel-c-qt-tr)
  ;; skeletons and makros MIGHT use C-b C-s as prefix if they get too many
  
  )

;;}}}

;;{{{ Perl Mode
;;-------------
(require 'ska-skel-perl)
(defun ska-cperl-mode-keys ()
  "Setting local keybindings for major mode: perl."
  (local-set-key '[(meta tab)]               'hippie-expand)
  (local-set-key '[(control b) (control b)]  'executable-interpret)
  ;; skeletons and makros MIGHT use C-b C-s as prefix if they get too many
  (local-set-key '[(control b) (control f)]  'ska-skel-perl-file-loop)
  (local-set-key '[(control b) (control s)]  'ska-skel-perl-sub)
  (local-set-key '[(control b) (control i)]  'ska-skel-perl-prog-id)
  (local-set-key '[(control b) (control o)]  'ska-skel-perl-options)
  )
;;}}}

;;{{{ Ruby Mode
;;-------------
(require 'ska-skel-ruby)
(defun ska-ruby-mode-keys ()
  "Setting local keybindings for major mode: Ruby."
  (local-set-key '[(meta tab)]               'hippie-expand)
  (local-set-key '[(control b) (control b)]  'run-ruby)
  (local-set-key '[(control b) (control e)]  'ruby-insert-end)
  (local-set-key '[(control b) (control d)]  'ska-skel-ruby-def)
  (local-set-key '[(control b) (control c)]  'ska-skel-ruby-class)
  (local-set-key '[(control b) (control h)]  'ska-skel-ruby-header)
  (local-set-key '[(control b) (control s)]  'ska-skel-ruby-string-subst)
  )
;;}}}

;;{{{ SQL Mode
;;------------
(require 'ska-skel-sql)
(defun ska-sql-mode-keys ()
  "Setting local keybindings for major mode: SQL."
  (local-set-key '[(control b) (control v)] 'ska-skel-sql-view)
  (local-set-key '[(control b) (control v)] 'ska-skel-sql-build)
  )
;;}}}

;;{{{ LaTeX Mode
;;--------------
(defun ska-latex-mode-keys ()
  "Set keys for latex-mode (AUCTeX)."
  (local-set-key '[(tab)]                    'LaTeX-indent-line)
  (define-key LaTeX-math-keymap
	(concat LaTeX-math-abbrev-prefix "/")    'LaTeX-math-frac)
)
(defun ska-bibtex-mode-keys ()
  "Set keys for bibtex-mode."
  (local-set-key '[(control return)]         'bibtex-next-field)
)
;;}}}

;;{{{ Emacs Lisp Mode
;;-------------------
(defun ska-elisp-mode-keys ()
  "Set keys for elisp-mode."
  (local-set-key '[(control b) (control b)]  'eval-buffer)
	)
;;}}}

;;{{{ VM and Mail
;;------
(require 'ska-skel-mail)
(defun ska-vm-keys ()
  "Set keybindings in VM Mailreader."
  (local-set-key '[(a)]                      'vm-toolbar-autofile-message)
)
(defun ska-mail-keys ()
  "Set keybindings for mail writing buffers."
  (local-set-key '[(control b) (control r)]  'ska-skel-mail-regards)
  (local-set-key '[(control b) (control k)]  'ska-skel-mail-coffee-or-tee)
  (local-set-key '[(control b) (control b)]  'ska-mail-insert-answer-gap)
  )
;;}}}


;;{{{ scilab
;;------------
;;}}}

;;{{{ SGML, XML and HTML
;;----------------------
(defun ska-sgml-keys ()
  "Set keybindings for all modes, done by PSGML."
  (local-set-key '[(control c) (control c)]  'sgml-insert-tag)
  )
;;}}}

(provide 'ska-local-keys)

;;; local-keys.el ends here
;; Local variables:
;; mode: emacs-lisp
;; folded-file: t
;; end:
