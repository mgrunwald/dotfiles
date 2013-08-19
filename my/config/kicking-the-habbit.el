;-*- coding: utf-8 -*-
; emacs keyboarding shortcuts
; this shortcut is for Dvorak keyboard users

; Xah Lee
; 2007-06
; ∑ http://xahlee.org/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; KICKING THE HABIT

(global-unset-key (kbd "M-\\")) ; delete-horizontal-space
(global-unset-key (kbd "M-@")) ; was mark-word
(global-unset-key (kbd "M--")) ; was negative-argument
(global-unset-key (kbd "M-<")) ; beginning-of-buffer
(global-unset-key (kbd "M->")) ; end-of-buffer

(global-unset-key (kbd "M-1")) ; digit-argument
(global-unset-key (kbd "M-2")) ; digit-argument
(global-unset-key (kbd "M-3")) ; digit-argument
(global-unset-key (kbd "M-4")) ; digit-argument
(global-unset-key (kbd "M-5")) ; digit-argument
(global-unset-key (kbd "M-6")) ; digit-argument
(global-unset-key (kbd "M-7")) ; digit-argument
(global-unset-key (kbd "M-8")) ; digit-argument
(global-unset-key (kbd "M-9")) ; digit-argument
(global-unset-key (kbd "M-0")) ; digit-argument

(global-unset-key (kbd "M-a")) ; backward-sentence
(global-unset-key (kbd "M-b")) ; backward-word
(global-unset-key (kbd "M-c")) ; capitalize-word
(global-unset-key (kbd "M-d")) ; kill-word
(global-unset-key (kbd "M-e")) ; forward-sentence
(global-unset-key (kbd "M-f")) ; forward-word
;(global-unset-key (kbd "M-g")) ; (prefix)
(global-unset-key (kbd "M-h")) ; mark-paragraph
;(global-unset-key (kbd "M-i")) ; tab-to-tab-stop
(global-unset-key (kbd "M-j")) ; indent-new-comment-line
(global-unset-key (kbd "M-k")) ; kill-sentence
(global-unset-key (kbd "M-l")) ; downcase-word
(global-unset-key (kbd "M-m")) ; back-to-indentation
(global-unset-key (kbd "M-n")) ; -
(global-unset-key (kbd "M-o")) ; -
(global-unset-key (kbd "M-p")) ; -
(global-unset-key (kbd "M-q")) ; fill-paragraph
(global-unset-key (kbd "M-r")) ; move-to-window-line
(global-unset-key (kbd "M-s")) ; -
(global-unset-key (kbd "M-t")) ; transpose-words
(global-unset-key (kbd "M-u")) ; upcase-word
(global-unset-key (kbd "M-v")) ; scroll-down
(global-unset-key (kbd "M-w")) ; kill-ring-save
(global-unset-key (kbd "M-x")) ; execute-extended-command
(global-unset-key (kbd "M-y")) ; yank-pop
(global-unset-key (kbd "M-z")) ; zap-to-char

(global-unset-key (kbd "C-1")) ; digit-argument
(global-unset-key (kbd "C-2")) ; digit-argument
(global-unset-key (kbd "C-3")) ; digit-argument
(global-unset-key (kbd "C-4")) ; digit-argument
(global-unset-key (kbd "C-5")) ; digit-argument
(global-unset-key (kbd "C-6")) ; digit-argument
(global-unset-key (kbd "C-7")) ; digit-argument
(global-unset-key (kbd "C-8")) ; digit-argument
(global-unset-key (kbd "C-9")) ; digit-argument
(global-unset-key (kbd "C-0")) ; digit-argument

(global-unset-key (kbd "C-/")) ; undo
(global-unset-key (kbd "C-_")) ; undo
(global-unset-key (kbd "C-<backspace>")) ; backward-kill-word

(global-unset-key [(control a)]) ; move-beginning-of-line
(global-unset-key [(control b)]) ; backward-char
;(global-unset-key [(control c)]) ; (prefix)
(global-unset-key [(control d)]) ; delete-char
(global-unset-key [(control e)]) ; move-end-of-line
(global-unset-key [(control f)]) ; forward-char
;(global-unset-key [(control g)]) ; keyboard-quit
;(global-unset-key [(control h)]) ; (prefix)
;(global-unset-key [(control i)]) ; indent-for-tab-command; this is tab key
;(global-unset-key [(control j)]) ; newline-and-indent
(global-unset-key [(control k)]) ; kill-line
(global-unset-key [(control l)]) ; recenter
;(global-unset-key [(control m)]) ; newline-and-indent
(global-unset-key [(control n)]) ; next-line
(global-unset-key [(control o)]) ; open-line
(global-unset-key [(control p)]) ; previous-line
;(global-unset-key [(control q)]) ; quote-insert
;(global-unset-key [(control r)]) ; isearch-backward
;(global-unset-key [(control s)]) ; isearch-forward ; won't work if in info
(global-unset-key [(control t)]) ; transpose-chars
;(global-unset-key [(control u)]) ; universal-argument
(global-unset-key [(control v)]) ; scroll-up
(global-unset-key [(control w)]) ; kill-region
;(global-unset-key [(control x)]) ; (prefix)
(global-unset-key [(control y)]) ; yank
(global-unset-key [(control z)]) ; iconify-or-deiconify-frame


;(global-unset-key (kbd "C-x C-f")) ; find-file
(global-unset-key (kbd "C-x d")) ; dired. (use find-file instead)

;(global-unset-key (kbd "<f10>")) ; was tmm-menubar

(provide 'kicking-the-habbit)
