;;; ska-global-keys.el --- global keybindings
;; Copyright (C) 2000 Stefan Kamphausen <mail@skamphausen.de>

;; Author: Stefan Kamphausen <mail@skamphausen.de>
;; Time-stamp: <09-Apr-2009 09:22:15 gru>

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
;; This sets the keybindings I want to have available in all modes.

;;; To Use:
;; put
;;    (load "ska-global-keys" t nil)
;; in an init file

;; see also: http://xahlee.org/emacs/keyboard_shortcuts.html


;;; Code:
(require 'ska-utils)
(require 'mg-utils)
(require 'chb-util)
(require 'redo)

;; My own prefix for globally available commands: C-v
;; (just like C-x and C-c for xemacs' defaults)
(global-unset-key '[(control v)])

;(global-set-key '[(control v) (f7)] 'xref-delete-window)


;;{{{ Navigation And Movement
;; ---------------------------
(define-key global-map '[kp-enter]		 [return])
;; Scrolling with keys
(global-set-key '[(control up)]            '(lambda ()	  (interactive)	  (scroll-down 1)))
(global-set-key '[(control down)]          '(lambda ()	  (interactive)	  (scroll-up 1)))
(global-set-key '[(control \.)]            'ska-point-to-register)
(global-set-key '[(control \,)]            'ska-jump-to-register)
(global-set-key '[(control backspace)]     'backward-kill-word)
(global-set-key  (kbd "C-SPC")         'set-mark-command)  ;; doesn't work for some reason...
(global-set-key '[(control delete)]        'kill-word)
(global-set-key '[(control <)]             'previous-buffer)
(global-set-key '[(control >)]             'next-buffer)
(global-set-key '[(f10)]                   'speedbar-get-focus)
(global-set-key '[(control v) (control s)] 'speedbar-get-focus)
(global-set-key "%"			   'mg-match-paren)
(global-set-key '[(control k)]             'mg-kill-entire-line)
(global-set-key '[(control x) (p)]         '(lambda () (interactive) (other-window -1)))
(global-set-key '[(control z)]             'yank)
(global-set-key '[(f11)]                   'previous-error)
(global-set-key '[(f12)]                    'next-error)
(global-set-key '[(control x) (notsign)]    'previous-error)
(global-set-key '[(control tab)]	    'other-window)
(global-set-key '[(home)]                  'mg-home)


( load "shift-mark" )

;;}}}

;;{{{ Mouse
;; ---------
;; The Hyperbole information manager package uses (shift button2) and
;; (shift button3) to provide context-sensitive mouse keys.  If you
;; use this next binding, it will conflict with Hyperbole's setup.
;; Choose another mouse key if you use Hyperbole.
;; CONTROL:
;; SHIFT: menus
(global-set-key '[(shift button2)]         'modeline-buffers-menu)
(global-set-key '[(shift button3)]         'mouse-function-menu)
;; META: rectangle operations. meta button1 is default
(global-set-key '[(meta button2)]          'yank-rectangle)
(global-set-key '[(meta button3)]          'kill-rectangle)

(global-set-key [C-wheel-up] '(lambda () (interactive) (text-scale-increase 1)))
(global-set-key [C-wheel-down] '(lambda () (interactive) (text-scale-decrease 1)))
;;=============================================================================
;;                    scroll on  mouse wheel
;;=============================================================================

; scroll on wheel of mouses
;; (define-key global-map '[button4]
;;   '(lambda (&rest args)
;;     (interactive)
;;     (let ((curwin (selected-window)))
;;       (select-window (car (mouse-pixel-position)))
;;       (scroll-down 5)
;;       (select-window curwin)
;; )))
;; (define-key global-map [(shift button4)]
;;   '(lambda (&rest args)
;;     (interactive)
;;     (let ((curwin (selected-window)))
;;       (select-window (car (mouse-pixel-position)))
;;       (scroll-down 1)
;;       (select-window curwin)
;; )))
;; (define-key global-map [(control button4)]
;;   '(lambda (&rest args)
;;     (interactive)
;;     (let ((curwin (selected-window)))
;;       (select-window (car (mouse-pixel-position)))
;;       (scroll-down)
;;       (select-window curwin)
;; )))

;; (define-key global-map '[button5]
;;   '(lambda (&rest args)
;;     (interactive)
;;     (let ((curwin (selected-window)))
;;       (select-window (car (mouse-pixel-position)))
;;       (scroll-up 5)
;;       (select-window curwin)
;; )))
;; (define-key global-map [(shift button5)]
;;   '(lambda (&rest args)
;;     (interactive)
;;     (let ((curwin (selected-window)))
;;       (select-window (car (mouse-pixel-position)))
;;       (scroll-up 1)
;;       (select-window curwin)
;; )))
;; (define-key global-map [(control button5)]
;;   '(lambda (&rest args)
;;     (interactive)
;;     (let ((curwin (selected-window)))
;;       (select-window (car (mouse-pixel-position)))
;;       (scroll-up)
;;       (select-window curwin)
;; )))

;;}}}

;;{{{ Function Keys
;; -----------------

;; keyboard macros
(global-set-key '[(f1)]                    'call-last-kbd-macro)
(global-set-key '[(f2)]                    'end-kbd-macro)
(global-set-key '[(f3)]                    'start-kbd-macro)
;; Buffer and Window operations
(global-set-key '[(f4)]                    'kill-this-buffer)
(global-set-key '[(control f4)]            'ska-kill-this-window)
;; (global-set-key '[(f5)]                    'delete-other-windows)
;; (global-set-key '[(shift f5)]              'delete-window)
;; (global-set-key '[f6]                      'split-window-vertically)
(global-set-key '[(shift f6)]              'split-window-horizontally)
(global-set-key '[f7]                      'shrink-window)
(global-set-key '[(shift f7)]              'shrink-window-horizontally)
(global-set-key '[f8]                      'enlarge-window)
(global-set-key '[(shift f8)]              'enlarge-window-horizontally)
(global-set-key '[(control f7)]            '(lambda ()
											  (interactive)
											  (set-frame-height
											   (selected-frame)
											   (- (frame-height) 1))))
(global-set-key '[(control f8)]            '(lambda ()
											  (interactive)
                                                						  (set-frame-height
											   (selected-frame)
											   (+ (frame-height) 1))))
;; The function keys with higher numbers seem to be used by some
;; packages so I won't rely on them
(global-set-key '[(shift f9)]              'repeat-complex-command)
;;}}}

;;{{{ Text Operation: Insert, Expand, ...
;; ---------------------------------------
(global-set-key '[(control t)]             'mg-delete-whitespace)
(global-set-key '[(control v) (control a)] 'chb-align-to-char-in-previous-line)
(global-set-key '[(control v) (control c)] 'set-justification-center)
(global-set-key '[(control v) (control d)] 'mg-insert-date )
(global-set-key '[(control v) (control e)] '(lambda () (interactive)(revert-buffer t t ) ) )
(global-set-key '[(control v) (control f)] 'fill-region)
(global-set-key '[(control v) (control m)] 'vm)
(global-set-key '[(control v) (control n)] 'gnus)
(global-set-key '[(control v) (control p)] 'ska-insert-path)
(global-set-key '[(control v) (control r)] 'chb-query-replace-by-example)
(global-set-key '[(control v) (control x)] 'ska-insert-exec-text)
(global-set-key '[(control v) (i) (b)    ] 'ispell-buffer )
(global-set-key '[(control v) (i) (r)    ] 'ispell-region )
(global-set-key '[(control v) (i) (t)    ] 'ispell-toggle-dictionary )
(global-set-key '[(control v) (control v)] 'magit-status )
(global-set-key '[(control v) (s)        ] 'sort-lines )
(global-set-key '[(meta insert)]           'yank-pop)
(global-set-key '[(shift delete )]         'kill-region)
(global-set-key (kbd "S-SPC")              'dabbrev-expand)
(global-set-key '[(control \?)]            'redo)

;;{{{ Font menu
;; ---------------------------------------
(global-set-key '[(control x) (F) (f)    ] 'facemenu-set-foreground )
(global-set-key '[(control x) (F) (a)    ] 'facemenu-set-background )
;;}}}


(global-set-key "\e#" 'calc-dispatch)


(provide 'ska-global-keys)

;;; ska-global-keys.el ends here
