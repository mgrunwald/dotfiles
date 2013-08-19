;; ------------------------------ COPYRIGHT NOTICE ------------------------------
;; wide-edit.el version 1.0
;; Author: Jesper K. Pedersen <blackie@klaralvdalens-datakonsult.se>
;; Copyright Klaralvdalens Datakonsult AB.
;; Home page: http://www.klaralvdalens-datakonsult.se/
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License along
;; with GNU Emacs.  If you did not, write to the Free Software Foundation,
;; Inc., 675 Mass Ave., Cambridge, MA 02139, USA.


;; ------------------------------ DESCRIPTION ------------------------------
;; wide-edit.el is for people who recognizes the following situation I had
;; once:
;;                                PROBLEM
;;
;; I needed to replace "bool" to "Boolean" in a number of files, A fast grep
;; though the files showed me that there where approx 2000 matches. Of course,
;; there where situation where the replacement should not be done.  For each
;; match it was pretty simply to decide whether the replacement should be done
;; or not. However, even replacing one instance every second using
;; tags-query-replace, would take 20 minutes. I did it that way, but I had to
;; pause every few minutes, because the trivial work lulled me to sleep.  Even
;; though I paused often, it showed up that I've made at least 10 errors (which
;; really only is 1 error for every 200 instance), and a rough estimate would
;; say that fixing these errors later costed up to a whole man-week of work!
;;
;;                                SOLUTION
;;
;; The solution to the problem above is a major mode called wide-edit, which
;; works on the output from grep. The fundamental thing about this major mode
;; is that whatever you change in the output from grep, gets written back into
;; the file the grep line talks about. This makes it possible to handle each
;; situation in turn: "Lines matching the keyword "SIGNAL" should not be replace,
;; lines which contains the word "ok", should very likely be replace" etc.
;; 
;;                                EXAMPLE
;;
;; A grep buffer may contain the following line:
;; /home/joe/project/main.cpp:131: bool b;
;;                                 ^^^^^^^
;; The text marked is the content of line 131 in main.cpp
;; If we now change the line so it says:
;; /home/joe/project/main.cpp:131: Boolean b;
;; Then this change is propagated back to the file main.cpp, so line 131 now
;; says Boolean rather than bool.
;;
;;                              KEY BINDINGS
;;
;; In the wide-edit buffer functionality like search-and-replace, macros,
;; rectangular command etc still works, which makes this superior to using
;; tags-query-replace. In addition, there is a number of extra functions, that
;; allows you to narrow to lines matching a regular expression, and only work
;; on these lines. The bindings are as follows:
;; 
;; C-c m - marks lines where the content matches a given regular expression.
;; C-c M - marks lines where the file name matches a given regular expression.
;; C-c o - marks lines where the content do not match ( o for nOt )
;; C-c O - marks lines where the file name do not match ( O for nOt )
;; C-c a - mark all lines above current line
;; C-c space - toggle mark on current line
;; C-c c - mark lines which has been changed
;; C-c i - inverse all marks
;; C-c r - remove all marks
;; 
;; C-c n - only show lines with marks (narrow)
;; C-c w - widen out from narrowing, ie. show all lines
;; C-c backspace - delete marked lines (ie. delete from grep buffer, not from
;;                 their  original place). This is a way to say, OK I've
;;                 handled these lines.
;;
;; C-c u - undo changes made to the current line
;; C-c h - delete info lines, these are typical lines telling about number of
;;         matches etc.
;;
;;                              ONE WARNING
;; 
;; Due to technicalities in the implementation, lines which are hidden during
;; narrowing (C-c n) are still visible to Emacs commands, such as 
;; search-and-replace, and rectangular commands. This means that if you narrow
;; you might experience that Emacs offers to replace text at the beginning of a
;; line, where you don't see the pattern searched for.
;; This makes the narow-widen feature less useful, but in most situation this
;; is not an issue, given the movement commands works fine.
;; Thus search-and-replace can be replaced with the following sequence of actions:
;; - Narrow till each line in the buffer contain a match (You are allowed to
;;   narrow in a narrowed buffer)
;; - record a macro, which replace the match on the current line for example by
;;   searching, and replacing text found. Next step of macro is to go to the
;;   next line of the buffer.
;; - run the macro on all the lines of the buffer.


;; ------------------------------ INSTALLATION ------------------------------
;; To use this file insert a line similar to the following to your .emacs file:
;; (load "wide-edit.el)
;;
;; If you want wide-edit to start automatically after grep and igrep, insert
;; the following line in your .emacs:
;; (wide-edit-insinuate-grep 't)
;;
;; Running igrep or grep should now automatically start wide-edit-mode. If it 
;; doesn't or you want to use this mode with output from another program,
;; simply type M-x wide-edit-mode.
;;
;; wide-edit need to modify next-error a bit to make it work with wide-edit. 
;; If you do not want it to do so, insert the following code after the load line:
;; (wide-edit-insinuate-next-error nil)

;; ---------------------------- code starts here ----------------------------

;----------------------------------------------------------------------
;                                 Mode Map
;----------------------------------------------------------------------
(defvar wide-edit-mode-map nil)   ; Create a mode-specific keymap.

(if wide-edit-mode-map
    ()              ; Do not change the keymap if it is already set up.
  (setq wide-edit-mode-map (make-sparse-keymap))
  (define-key wide-edit-mode-map [(control c) (h)] 'wide-edit-delete-info-lines)
  (define-key wide-edit-mode-map [(control c) (c)] 'wide-edit-mark-changed-line)
  (define-key wide-edit-mode-map [(control c) (m)] 'wide-edit-mark-content-matches)
  (define-key wide-edit-mode-map [(control c) (o)] 'wide-edit-mark-content-non-matches)
  (define-key wide-edit-mode-map [(control c) (M)] 'wide-edit-mark-filename-matches)
  (define-key wide-edit-mode-map [(control c) (O)] 'wide-edit-mark-filename-non-matches)
  (define-key wide-edit-mode-map [(control c) (n)] 'wide-edit-narrow-to-mark)
  (define-key wide-edit-mode-map [(control c) (w)] 'wide-edit-widen)
  (define-key wide-edit-mode-map [(control c) (space)] 'wide-edit-toggle-mark)
  (define-key wide-edit-mode-map [(control c) (i)] 'wide-edit-inverse-all-marks)
  (define-key wide-edit-mode-map [(control c) (r)] 'wide-edit-clear-marks)
  (define-key wide-edit-mode-map [(control c) (backspace)] 'wide-edit-remove-marked)
  (define-key wide-edit-mode-map [(control c) (a)] 'wide-edit-mark-above)


  (define-key wide-edit-mode-map [(up)] 'wide-edit-prev-line)
  (define-key wide-edit-mode-map [(control p)] 'wide-edit-prev-line)
  (define-key wide-edit-mode-map [(kp-up)] 'wide-edit-prev-line)

  (define-key wide-edit-mode-map [(down)] 'wide-edit-next-line)
  (define-key wide-edit-mode-map [(control n)] 'wide-edit-next-line)
  (define-key wide-edit-mode-map [(kp-down)] 'wide-edit-next-line)

  (define-key wide-edit-mode-map [(control a)] 'wide-edit-beginning-of-line)
  (define-key wide-edit-mode-map [(kp-home)] 'wide-edit-beginning-of-line)
  (define-key wide-edit-mode-map [(begin)] 'wide-edit-beginning-of-line)
  (define-key wide-edit-mode-map [(kp-begin)] 'wide-edit-beginning-of-line)

  (define-key wide-edit-mode-map [(return)] 'wide-edit-goto-content)
  (define-key wide-edit-mode-map [(button2)] 'wide-edit-mouse-goto)
  (define-key wide-edit-mode-map [(control x) (control s)] 'wide-edit-save-changes)
  (define-key wide-edit-mode-map [(control c) (u)] 'wide-edit-undo-current-change)

  )

;----------------------------------------------------------------------
;                                   Faces
;----------------------------------------------------------------------
(make-face 'wide-edit-info-text-face
  "Face used for info text is shown with (info text is text like 'grep command is ....)'")
(set-face-foreground 'wide-edit-info-text-face "grey70")

(make-face 'wide-edit-marked-face
  "Face used for marked lines")
(set-face-foreground 'wide-edit-marked-face "black")
(set-face-background 'wide-edit-marked-face "orange")

(make-face 'wide-edit-file-info-face
   "Face used on the part saying 'File:line-no:'")
(set-face-foreground 'wide-edit-file-info-face "orange")
(set-face-background 'wide-edit-file-info-face "white")


(make-face 'wide-edit-unmarked-face
  "Face used for marked lines")

;----------------------------------------------------------------------
;                                Mode Setup
;----------------------------------------------------------------------
(defun wide-edit-mode ()
  "Major mode for editing buffers which result from grep or similar commands
  Special Commands: \\{wide-edit-map}"

  (interactive)
  (kill-all-local-variables)
  (use-local-map wide-edit-mode-map)
  (setq mode-name "Wide-Edit")           ; This name goes into the modeline.
  (setq major-mode 'wide-edit-mode)      ; This is how `describe-mode'
                                         ; finds the doc string to print.
  (wide-edit-init-buffer)
  (run-hooks 'wide-edit-mode-hook)  

  (make-local-variable 'kill-buffer-hook)
  (setq kill-buffer-hook 'wide-edit-ask-to-save)
  (setq compilation-last-buffer (current-buffer))
  (make-local-variable 'wide-edit-init)
  (setq wide-edit-init 't)
)

(defun wide-edit-init-buffer ()
  "Sets up the buffer for wide-edit."
  (save-excursion
    ;; Kill all existig extents
    (let (ext (extents (extent-list)))
      (while extents
        (setq ext (car extents))
        (setq extents (cdr extents))
        (delete-extent ext)))

    ;; set new extent
    (let ((more 't))
      (goto-char (point-min))
      (while (and more (not (= (point) (point-max))))
        (if (looking-at "\\([^: \n]+\\):\\([0-9]+\\):")
            ;; A match line
            (let* ((start (point))
                  (end (progn (end-of-line) (point)))
                  (mid (match-end 0))
                  (ext1 (make-extent start mid))
                  (ext2 (make-extent start (+ 1 end))))
              (set-extent-properties ext1 
                                     '(face wide-edit-file-info-face read-only t mark t))
              (set-extent-properties ext2 
                                     '(face wide-edit-unmarked-face matched-line t))
              (set-extent-property ext2 'orig-content (buffer-substring mid end))
              (set-extent-property ext2 'file (match-string 1))
              (set-extent-property ext2 'line (match-string 2))
              (set-extent-property ext2 'offset (- mid start))
              (set-extent-property ext2 'co-extent ext1)
              )
          
          ;; Not looking at a match line
          (let* ((start (point))
                 (end (+ 1 (progn (end-of-line) (point))))
                 (extent (make-extent start end)))
            (progn
              (set-extent-property extent 'read-only 't)
              (set-extent-face extent 'wide-edit-info-text-face)
              (set-extent-property extent 'unmatched-line 't))
            ))
        (setq more (eq (forward-line) 0))
        
        ))
    (set-buffer-modified-p nil)))

(defadvice igrep (before wide-edit-igrep-advice dis)
  (setq compilation-finish-function 'wide-edit-highlight-grep)

  ;; Clean out *igrep* as wide-edit might in a previous run
  ;; have made them partly read-only.
  (let ((igrep (get-buffer "*igrep*")))
    (if igrep
        (kill-buffer igrep))))

(defadvice grep (before wide-edit-grep-advice dis)
  (setq compilation-finish-function 'wide-edit-highlight-grep)

  ;; Clean out *grep*, as wide-edit might in a previous run
  ;; have made them partly read-only.
  (let ((grep (get-buffer "*grep*")))
    (if grep
        (kill-buffer grep))))

(defadvice grep (before wide-edit-igrep-advice dis)
  (setq compilation-finish-function 'wide-edit-highlight-grep))

(defun wide-edit-insinuate-grep (on)
  (if on
      (progn
        (ad-enable-advice 'igrep 'before 'wide-edit-igrep-advice)
        (ad-enable-advice 'grep 'before 'wide-edit-grep-advice))
    (progn
      (ad-disable-advice 'igrep 'before 'wide-edit-igrep-advice)
      (ad-disable-advice 'grep 'before 'wide-edit-grep-advice)))
  (ad-activate 'igrep)
  (ad-activate 'grep))

(defun wide-edit-highlight-grep (buffer str)
  (set-buffer buffer)
  (wide-edit-mode)
  (setq compilation-finish-function nil))

;----------------------------------------------------------------------
;                           Misc
;----------------------------------------------------------------------
(defun wide-edit-delete-info-lines ()
  "Delete lines which are not part of the grep search that set up this buffer.
  These lines are typically telling about the grep command etc, but are not part of the grep result"
  (interactive)
  (let ((list (extent-list (current-buffer) (point-min) (point-max) nil 'unmatched-line 't ))
        ext)
    (while list
      (setq ext (car list))
      (setq list (cdr list))
      (set-extent-property ext 'read-only nil)
      (delete-region (extent-start-position ext) (extent-end-position ext)))))

(defun wide-edit-mark-changed-line ()
  "Mark lines with changes"
  (interactive)
  (map-extents (lambda (ext mapargs)
                 (set-extent-property ext 'mark (wide-edit-line-changed ext)) 
                 nil)
               (current-buffer) (point-min) (point-max) nil nil 'matched-line 't)
  (wide-edit-highlight-marked)
  )

(defun wide-edit-line-changed (ext)
  "Returns whether there is any change for the given extent"
  (let ((str (buffer-substring (+ (extent-property ext 'offset) (extent-start-position ext))
                                  (- (extent-end-position ext) 1))))
    (not (equal str (extent-property ext 'orig-content)))))

(defun wide-edit-undo-current-change ( &optional extent )
  "Undo changes on the current line"
  (interactive)
  (let ((ext (if extent 
                 extent 
               (extent-at (point) (current-buffer) 'matched-line)))
        start)
    (if ext
        (progn
          (setq start (+ (extent-property ext 'offset) (extent-start-position ext)))
          (delete-region start (- (extent-end-position ext) 1))
          (goto-char start)
          (insert (extent-property ext 'orig-content))))))

;----------------------------------------------------------------------
;                                  Saving
;----------------------------------------------------------------------
(defun wide-edit-save-changes ()
  (interactive)

  (let ( (quit-now nil) 
         (mark-all nil)
         (replace-all nil)
         (wide-edit-buffer (current-buffer))
         orig-content new-content existing-content answer replace-this buffer ) 
    (wide-edit-clear-marks)

    (map-extents 
     (lambda (ext mapargs)
       (set-buffer wide-edit-buffer)
       (setq orig-content (extent-property ext 'orig-content))
       (setq new-content (buffer-substring (+ (extent-property ext 'offset) (extent-start-position ext))
                                           (- (extent-end-position ext) 1)))

       (if (wide-edit-line-changed ext)
           (progn
             (setq buffer (wide-edit-goto-pos ext nil))
             (setq existing-content (buffer-substring (point) (progn (end-of-line) (point))))

             (setq
              replace-this nil
              mark-this nil)

             ;; Test if the content on the line to modify is equal to the original content
             (if (or replace-all (equal existing-content orig-content))
                 (setq replace-this 't)
               (if (not mark-all)
                   ;; content didn't match
                   (progn
                     (setq answer (wide-edit-replace-this-match ext existing-content new-content))
                     (if (equal answer "y")
                         (setq replace-this 't)
                       (if (equal answer "n")
                           (wide-edit-undo-current-change ext)
                         (if (or (equal answer "q") (equal answer ""))
                             (setq quit-now 't)
                           (if (equal answer "m")
                               (setq mark-this 't)
                             (if (equal answer "M")
                                 (setq mark-all 't)
                               (if (equal answer "!")
                                   (setq replace-all 't))))))))))
               
             (if quit-now
                 't ; return 't stop the map-extents
               
               (progn
                 (if (or replace-this replace-all)
                     (progn
                       (set-buffer buffer)
                       (delete-region (progn (beginning-of-line) (point))
                                      (progn (end-of-line) (point)))
                       (insert new-content)
                       (set-extent-property ext 'orig-content new-content))
                   (if (or mark-this mark-all)
                       (set-extent-property ext 'mark 't)))
                 nil)))) ; return nil to continue map-extent
         nil) ; return nil to continue map-extent
       
       (current-buffer) (point-min) (point-max) nil nil 'matched-line 't)
     (set-buffer wide-edit-buffer)
     (wide-edit-highlight-marked)
     (set-buffer-modified-p nil)))
  
(defun wide-edit-replace-this-match (ext existing replacement)
  (let ((buffer (get-buffer-create "*Wide-Edit-Questions*"))
        answer map i)
    (set-buffer buffer)
    (delete-region (point-min) (point-max))
    (insert "The original file did not contain the text expected!\n")
    (insert "-----\n")
    (insert "Expected text:     ")
    (insert (extent-property ext 'orig-content))
    (insert "\nFound text:        ")
    (insert existing)
    (insert "\nReplacemenmt text: ")
    (insert replacement)
    (insert "\n-----\n")
    (insert "Here's your option:\n")
    (insert "y - yes, save this change\n")
    (insert "n - no, please undo this change in my wide-edit buffer\n")
    (insert "m - mark this line, but do not save now\n")
    (insert "M - mark all line which do not match, and let me look at them afterwards (saving those which do match)\n")
    (insert "! - override any difference - BE CAREFULL!\n")
    (insert "q - quit")
    (toggle-read-only 1)
    (set-window-buffer (selected-window) buffer)

    ;; Create keymap only containing ynmM and '!'
    (setq map (make-keymap))
    (setq i 32)
    (while (< i 255)
      (define-key map (int-char i) (lambda () (interactive) nil))
      (setq i (+ i 1)))
    (define-key map [(y)] 'self-insert-and-exit)
    (define-key map [(n)] 'self-insert-and-exit)
    (define-key map [(m)] 'self-insert-and-exit)
    (define-key map [(M)] 'self-insert-and-exit)
    (define-key map [(!)] 'self-insert-and-exit)
    (define-key map [(control g)] 'self-insert-and-exit)
    (define-key map [(q)] 'self-insert-and-exit)
    
    (setq answer (read-from-minibuffer "What to do (y,n,m,M,!,q) " nil map ))
    (kill-buffer buffer)
    
    answer ))

(defun wide-edit-ask-to-save ()
  "Asks the user if he was to save changes - connected to save hook"
  (let ((changes nil))
    (map-extents
     (lambda (ext args)
       (if (wide-edit-line-changed ext)
           (progn
             (setq changes 't)
             't)
         nil))
       (current-buffer) (point-min) (point-max) nil nil 'matched-line 't)

    (if changes
        (if (yes-or-no-p "Save unsaved changes? ")
            (wide-edit-save-changes)))))

;----------------------------------------------------------------------
;                            Mark functions
;----------------------------------------------------------------------
(defun wide-edit-mark-content-matches ( arg )
  "Mark lines which matches a regular expression on the content part.
  The regular expression will be queried in the mini-buffer.

  If this function is called without a prefix, all marks will be cleared before matching, and only 
  lines which matches the regexp will be matched

  If this functions is called with C-u as prefix, the query will only be done on those lines
  which is already marked, thus this is an 'and' query.

  If this function is called with C-u C-u as prefix, those lines which already has a mark, will continue
  having a mark, and the query is called among the other lines. This this is an 'or' query."
  (interactive "p")
  (wide-edit-mark-or-unmark "Regexp to match on content: " '(lambda (x) x) arg nil))

(defun wide-edit-mark-content-non-matches ()
  "Mark lines which do NOT match a regular expression on the content part.
  The regular expression will be queried in the mini-buffer.
  See wide-edit-mark-content-matches for a description of arguments."
  (interactive)
  (wide-edit-mark-or-unmark "Regexp NOT to match on content: " '(lambda (x) (not x)) arg nil))

(defun wide-edit-mark-filename-matches ( arg )
  "Mark lines which matches a regular expression on the filename part of the line.
  The regular expression will be queried in the mini-buffer.
  See wide-edit-mark-content-matches for a description of arguments."
  (interactive "p")
  (wide-edit-mark-or-unmark "Regexp to match on file name: " '(lambda (x) x) arg t))

(defun wide-edit-mark-filename-non-matches ( arg )
  "Mark lines which do not matches a regular expression on the filename part of the line.
  The regular expression will be queried in the mini-buffer.
  See wide-edit-mark-content-matches for a description of arguments."
  (interactive "p")
  (wide-edit-mark-or-unmark "Regexp to match on file name: " '(lambda (x) (not x)) arg t))

(defun wide-edit-mark-or-unmark ( question possible-not-fn arg match-files )
  "mark lines which matches or doesn't match a regular expression."
  "This function is a utility function for wide-edit-mark-matches and wide-edit-mark-non-matches
   `question' is the question to ask the user
   `possible-not-fn' is a function taking one argument and returning either the argument or the argument negated.
   This function is used to control whether we are searching for matches or non-marches.
   'arg' is the prefix argument to the function calling this - see description for wide-edit-mark-matches"
  (save-excursion
    (let ((regexp (read-from-minibuffer question))
          (list (extent-list (current-buffer) (point-min) (point-max) nil 'matched-line 't ))
          ext str pred-fn)

      ( if (= arg 1)
          (progn 
            ;; clean prev matches
            (wide-edit-clear-marks)
            (setq pred-fn 'or)))
      
      (if (= arg 4)
          ;; mark only those which matches both this and the previous query
          (setq pred-fn 'and))
      
      (if (= arg 16)
          ;; mark both previos marches and matches of this query
          (setq pred-fn 'or))
      
      (while list
        (setq ext (car list))
        (setq list (cdr list))
        (if match-files
            (setq str (extent-property ext 'file))
          (setq str (buffer-substring (+ (extent-property ext 'offset) (extent-start-position ext))
                                      (- (extent-end-position ext) 1))))
        (set-extent-face ext nil)
        (set-extent-property ext 'mark  
                             (eval `(,pred-fn (extent-property ext 'mark nil)
                                              (funcall possible-not-fn (string-match regexp str))))))
      (wide-edit-highlight-marked))))

(defun wide-edit-clear-marks ()
  "remove all marks"
  (interactive)
  (map-extents (lambda (ext mapargs)
                 (set-extent-property ext 'mark nil)
                 nil)
               (current-buffer) (point-min) (point-max) nil nil 'matched-line 't)
  (wide-edit-highlight-marked))

(defun wide-edit-highlight-marked ()
  "Highligt lines containing mark
   This command should be called from any function modifying the marks"
  (map-extents (lambda (ext mapargs)
                 (if (extent-property ext 'mark)
                     (set-extent-face ext 'wide-edit-marked-face)
                   (set-extent-face ext 'wide-edit-unmarked-face))
                 nil)
               (current-buffer) (point-min) (point-max) nil nil 'matched-line 't))

                     

(defun wide-edit-toggle-mark (arg)
  "Toggle marks on line. With arg, that amount of lines are toggled"
  (interactive "p")
  (let ( (count (if arg arg 1)))
    (while ( not (= count 0 ) )
      (let ((ext (extent-at (point) (current-buffer) 'matched-line)))
        (if ext
            (set-extent-property ext 'mark (not (extent-property ext 'mark))))
        (if ( > count 0 )
            (progn
              (setq count (- count 1) )
              (wide-edit-next-line))
          (progn
            (setq count (+ count 1) )
            (wide-edit-prev-line)))))
    (wide-edit-highlight-marked)))
      

(defun wide-edit-inverse-all-marks ()
  "Inverse marks"
  (interactive)
  (map-extents (lambda (ext mapargs)
                 (set-extent-property ext 'mark (not (extent-property ext 'mark)))
                 nil) (current-buffer) (point-min) (point-max) nil nil 'matched-line 't)
  (wide-edit-highlight-marked))

(defun wide-edit-mark-above ()
  "Mark all lines above this one"
  (interactive)
  (let ((p (point)))
    (map-extents (lambda (ext mapargs)
                   (if ( < (extent-start-position ext) p )
                       (set-extent-property ext 'mark 't))
                 nil) (current-buffer) (point-min) (point-max) nil nil 'matched-line 't)
    (wide-edit-highlight-marked)))
  
;----------------------------------------------------------------------
;                   Narrow and widening
;----------------------------------------------------------------------
(defun wide-edit-narrow-to-mark ()
  "Show only lines containing the mark - use wide-edit-widen to see all lines again.
   Note, you can narrow down several times, but only widen once."
  (interactive)
  (map-extents (lambda (ext mapargs) 
                 (if (not (extent-property ext 'mark nil))
                     (progn
                       (set-extent-property ext 'invisible 't)
                       (set-extent-property ext 'read-only 't)))
                 nil))
  (wide-edit-clear-marks)
  (wide-edit-highlight-marked))

(defun wide-edit-widen (arg)
  "widen to show all lines (see wide-edit-narrow)
   If arg is greater than 1 (e.g. by pressing C-u as prefix to this command), then
   all items curenntly visible will be marked."
  (interactive "p")
  
  ;; Mark those visible now
  (if (> arg 1)
      (map-extents (lambda (ext mapargs)
                          (if (not (extent-property ext 'invisible))
                              (set-extent-property ext 'mark t))
                          nil)))

  (map-extents (lambda (ext mapargs)
                (set-extent-property ext 'invisible nil)
                (set-extent-property ext 'read-only nil)
                nil))

  (wide-edit-highlight-marked))


(defun wide-edit-remove-marked (arg)
  "remove lines marked, possible saving if any is changed"
  (interactive "P")
  (let ((do-save arg)
        (extents '())
        ext)
    (map-extents 
     (lambda (ext mapargs)
       
       (if (extent-property ext 'mark)
           (progn
             (if (wide-edit-line-changed ext)
                 (if (yes-or-no-p "Some of the marked lines contain changes. Save befor deleting? ")
                     (setq do-save 't)))
             (setq extents (cons ext extents))))
       nil)
     (current-buffer) (point-min) (point-max) nil nil 'matched-line 't)

    (if do-save
        (wide-edit-save-changes))
      
    (while extents
      (setq ext (car extents))
      (setq extents (cdr extents))
      (delete-extent (extent-property ext 'co-extent))
      (delete-region (extent-start-position ext) (extent-end-position ext)))))

  
  

;----------------------------------------------------------------------
;                         Movement
;----------------------------------------------------------------------

(defun wide-edit-next-line ()
  "Move point to the next visible line in a wide-edit buffer"
  (interactive)
  (wide-edit-move 1 'end-of-buffer))

(defun wide-edit-prev-line ()
  "Move point to the previous visible line in a wide-edit buffer"
  (interactive)
  (wide-edit-move -1 'beginning-of-buffer))

(defun wide-edit-move (count errmsg)
  "Move point count line up or down
   Point will be moved up if count is negative.
   show errmsg if at the boundary of the buffer"
  (let* ((more 't)
         (offset (current-column))
        ext)
    (while more
      (setq more nil)
      (if (not (eq (forward-line count) 0))
          (error errmsg))
      (setq ext (extent-at (point) (current-buffer) 'matched-line))
      (if ext
          (progn
            (setq more (extent-property ext 'invisible))
            (if (not more)
                (move-to-column (min (max offset (extent-property ext 'offset)) (progn (end-of-line) (current-column))))))
        (setq more 't)))))

(defun wide-edit-beginning-of-line ()
  "Goto the beginning of line"
  (interactive)
    (let ((ext (extent-at (point) (current-buffer) 'matched-line)))
      (if ext
          (move-to-column (extent-property ext 'offset))
        (beginning-of-line))))

(defun wide-edit-goto-content ( &optional extent wide-edit-buffer)
  "Jump to the line in the file specified at the current match line"
  (interactive)
  (let ((ext (if extent extent (extent-at (point) (current-buffer) 'matched-line))))
    (if ext
        (progn
          (if wide-edit-buffer
              (set-window-buffer (selected-window) wide-edit-buffer))
          (setq compilation-last-buffer (current-buffer))
          (wide-edit-goto-pos ext 't))
      (error "not on a matched line"))))

(defun wide-edit-mouse-goto (event)
  "Jumps to the extent under mouse"
  (interactive "e")
  (mouse-set-point event)
  (setq compilation-last-buffer (current-buffer))
  (wide-edit-goto-content))

(defun wide-edit-goto-pos (ext show)
  (let ((filename (extent-property ext 'file))
        buffer)
    (if (file-exists-p filename)
        (progn
          (if show
              (setq buffer (find-file-other-window filename))
            (setq buffer (find-file-noselect filename)))
          (set-buffer buffer)
          (widen)
          (goto-line (string-to-number (extent-property ext 'line))))
      (error "file did not exist"))
    buffer)) ;return value

(defun wide-edit-next-error (&optional argp)
  "This is a replacement of next-error function.
It calls wide-edit-internal-next-error if the current compilation buffer is
in wide edit mode, otherwide it call the original next-error from compile.el.
The original next-error is avaiable from wide-edit-next-error-orig"
  (interactive "P")
  
  (if (and (bufferp compilation-last-buffer)
           (wide-edit-buffer compilation-last-buffer))
      (wide-edit-internal-next-error)
    (wide-edit-next-error-orig argp)))

(defun wide-edit-buffer (buffer) 
  "return whether `buffer´ is in wide-edit-mode"
  (save-excursion
    (set-buffer buffer)
    (eq major-mode 'wide-edit-mode)))
  
(defun wide-edit-internal-next-error ()
  "Goto next error"
  (progn
    (pop-to-buffer compilation-last-buffer)
    (if wide-edit-init
        (progn
          (goto-char (point-min))
          (setq wide-edit-init nil)))
    (wide-edit-next-line)
    (set-window-start (get-buffer-window (current-buffer)) 
                      (save-excursion (beginning-of-line) (point)))
    (wide-edit-goto-content)))
  
;; next-error do not contain proper hooks for makeing it work with wide-edit
;; Therefore I need to replace the body of the function.
(defun wide-edit-insinuate-next-error (on)
  "make next-error understand wide-edit buffers"
  (require 'compile)
  (if on
      (if (not (eq (symbol-function 'next-error) (symbol-function 'wide-edit-next-error)))
          (progn
            (fset 'wide-edit-next-error-orig (symbol-function 'next-error))
            (fset 'next-error (symbol-function 'wide-edit-next-error))))
    (if (and (eq (symbol-function 'next-error) (symbol-function 'wide-edit-next-error))
             (boundp 'wide-edit-next-error-orig))
        (fset 'next-error (symbol-function 'wide-edit-next-error-orig)))))
        


(wide-edit-insinuate-next-error 't)
