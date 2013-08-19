;; -*- Mode: Emacs-Lisp -*-
;; Newsserver
(setq gnus-select-method (quote (nntp "news.dacotec.de")))

;; Groups Buffer
;; Group Line
;;(setq gnus-group-line-format
;;      "%M%S%p%5y: %(%~(pad-right 60)g%)  
;;                                 Last read on %6,6~(cut 2)d\n")

(add-hook 'gnus-group-mode-hook
	  ;; Sorting Groups
	  'gnus-topic-mode)

(add-hook 'gnus-startup-hook
	  ;; Get Toolbar back
	  '(lambda () 
	     (if (featurep 'toolbar)
		 (set-specifier default-toolbar-visible-p t)
	      )
	     )
	  )

(add-hook 'gnus-exit-gnus-hook
	  ;; Toolbar off
	  '(lambda () 
	     (if (featurep 'toolbar)
		 (set-specifier default-toolbar-visible-p nil)
	       )
	     )
	  )

;; Article Buffer
(progn
  (setq gnus-build-sparse-threads 'some
	gnus-use-trees t
	gnus-generate-tree-function 'gnus-generate-horizontal-tree
	gnus-tree-minimize-window nil)
  (gnus-add-configuration  
   '(article
     (vertical 1.0
	       (horizontal 0.25
			   (summary 0.75 point)
			   (tree 1.0))
	       (article 1.0))))
  )
;; Scoring
(setq   gnus-use-adaptive-scoring t)
(defvar gnus-default-adaptive-score-alist
  '((gnus-unread-mark)
    (gnus-ticked-mark (from 4))
    (gnus-dormant-mark (from 5))
    (gnus-del-mark (from -4) (subject -1))
    (gnus-read-mark (from 1) (subject 1))
    (gnus-expirable-mark (from -1) (subject -1))
    (gnus-killed-mark (from -1) (subject -3))
    (gnus-kill-file-mark)
    (gnus-ancient-mark)
    (gnus-low-score-mark)
    (gnus-catchup-mark (subject -4) (from -1))
    )
  )
;; Misc settings
(setq gnus-large-newsgroup 500)
(setq gnus-show-mime t)
(setq gnus-article-save-directory "~/Guinan/News/")
(setq gnus-fetch-old-headers t)

;; Picons ??
(setq gnus-use-picons t)
(setq gnus-picons-database "~/Picard/Picons")
(add-hook 'gnus-article-display-hook 'gnus-article-display-picons t)
(add-hook 'gnus-summary-prepare-hook 'gnus-group-display-picons t)
(add-hook 'gnus-article-display-hook 'gnus-picons-article-display-x-face)
(setq gnus-picons-display-where 'article)

;; Saving Files
(setq gnus-default-article-saver 'gnus-summary-save-in-file)
(setq gnus-file-save-name 'gnus-Numeric-save-name)

;; Von Kai Grossjohann
(defun mark-region-as-included (b e)
  (interactive "r")
  (goto-char (- e 1))
  (if (looking-at "\n") () (forward-char 1))
  (if (eobp) (progn (insert "\n") (backward-char 1)))
  ;; we are at the end of the line
  (setq e (point))
  (forward-char 1)
  (insert "`-----\n")
  (string-rectangle b e "| ")
  (goto-char b)
  (insert ",-----\n")
  )
(define-key message-mode-map [?\C-\M-,] 'mark-region-as-included)
