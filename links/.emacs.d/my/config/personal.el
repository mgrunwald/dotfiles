;;; personal.el --- Setup modes, hooks and other personal stuff

(defvar my-lisp-dir
  (concat my-emacs-dir "lisp/")
  "The personal lisp directory. All self-written files and files from
the web goe here. Larger packages like e.g. VM or PSGML are installed
in subdirs."
  )

(defvar my-vendor-dir "~/emacs-vendor/"
  "This directory contains third party libraries"
  )

(defvar my-config-dir
  (concat my-emacs-dir "config")
  "This directory contains the configuration files. Keybindings as well
as local/personal settings plus init files of other packages
e.g. vm-init-file"
  )

(defvar my-templates-dir
  (concat my-emacs-dir "templates")
  "This directory contains all templates, inserting features and
skeletons I use together with XEmacs."
  )
(defvar my-data-dir
  (concat my-emacs-dir "data")
  "This directory contains all data XEmacs likes to store."
  )

(if (eq system-type 'windows-nt)
    (setenv "PATH" ( concat "c:\\MinGW\\msys\\1.0\\bin;" (getenv "PATH") ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Setting paths and list

(setq load-path
      (append
       (list
        my-config-dir
        my-templates-dir
        my-lisp-dir
        (concat my-lisp-dir "emacs-rails")
        (concat my-vendor-dir "web-mode" )
        (concat my-vendor-dir "rinari" )
        (concat my-vendor-dir "s.el" )
        (concat my-vendor-dir "ri" )
        ;;(concat my-lisp-dir "psgml-1.2.2")
        (concat my-lisp-dir "tools")
        (concat my-lisp-dir "bookmark+")
        )
       load-path
       )
      )

;;    Loading the site files
;; (hopefully) the only file with user specific informations
(load "user" nil nil)

;; Maybe I could use this some time for site specific settings...
;(setq my-host-file
;         (concat my-config-dir "/"
;                         (replace-in-string (exec-to-string "hostname")
;                                                                "\n" "")
;                         ".el"))
;(if (file-readable-p my-host-file)i
;       (load my-host-file nil nil))
;(setq my-domain-file
;         (concat my-config-dir "/"
;                         (replace-in-string (exec-to-string "domainname")
;                                                                "\n" "")
;                         ".el"))
;(if (file-readable-p my-domain-file)
;       (load my-domain-file nil nil))

;; (autoload 'last-weekday-of-month-p "mg-utils.el" "Function to detect whether a given date is the last weekday of the
;;   month.
;; Usage: (last-weekday-of-month-p date)
;; " t)

;; (autoload 'msys-file-name-handler "mg-utils.el" "Call `unmsys--file-name' on file names." t)
;; (autoload 'save-match-data-advice "mg-utils.el" "Add this as `:around' advice to save the match-data." t)

(if (require 'german-holidays "german-holidays" t)
    (setq calendar-holidays holiday-german-BY-holidays))

( set-locale-environment "de_DE@UTF8" )

;;{{{ The settings of the new filenames for some packages
(setq vm-init-file            (concat my-config-dir "/vm-init.el"))
(setq gnus-init-file          (concat my-config-dir "/gnus-init.el"))
(setq save-place-file         (concat my-data-dir   "/places.el"))
(setq recent-files-save-file  (concat my-data-dir       "/recent-files.el"))
(setq bbdb-file               (concat my-data-dir   "/bbdb"))
;; uhm what exactly is this??
(setq shadow-info-file        (concat my-data-dir   "/shadows"))
(setq shadow-todo-file        (concat my-data-dir   "/shadow_todo"))
;;}}}


;;(load "kicking-the-habbit.el" )
(load "ergonomic_keybinding_qwerty.el")
(require 'ska-global-keys)
(require 'ska-local-keys)
(require 'diminish)
(require 'yasnippet)

(yas-global-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Modes

;;; Remove the trailing white spaces
;;; From Noah Friedman
;;; http://www.splode.com/users/friedman/software/emacs-lisp/
;; (autoload 'nuke-trailing-whitespace "nuke-trailing-whitespace" nil t)
;; (add-hook 'mail-send-hook 'nuke-trailing-whitespace)
;; (add-hook 'write-file-hooks 'nuke-trailing-whitespace)
;; (add-hook 'write-file-hooks nil)
;;
;; (setq write-file-hooks nil)  for emergencies
;;
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'text-mode-hook
      '(lambda ()
         (auto-fill-mode 1)
         (abbrev-mode 1)
         (toggle-truncate-lines nil)
         (setq word-wrap t)
         (auto-fill-mode nil)
         (message "==================== text-mode-hook ====================")
         ))

(add-hook 'enriched-mode-hook
      '(lambda ()
;;       (load "ergonomic_keybinding_qwerty.el")
         (message "==================== enriched-mode-hook ====================")
         ))

(add-hook 'cperl-mode-hook
      '(lambda ()
         (abbrev-mode 1)
         ;; my keybindings
         (ska-coding-keys cperl-mode-map)
         (ska-cperl-mode-keys)
         (auto-fill-mode 1)
         ;; if you don't want tabs
         ;;(setq indent-tabs-mode nil)
         ;; full featured mode:
         (setq cperl-hairy t)
         ;; alternatively:
         ;;(setq cperl-auto-newline-after-colon t)
         ;;(setq cperl-electric-parens "({[")
         (setq cperl-auto-newline nil)
         (setq cperl-electric-linefeed t)
         (cperl-set-style "C++")
         (message "==================== cperl-mode-hook ====================")
         ))

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (gtags-mode t)
             (if gtags-auto-update
                 (add-hook 'after-save-hook 'gtags-update-hook))
             (ska-coding-keys ruby-mode-map)
             (ska-ruby-mode-keys)
             (rinari-minor-mode)
             (flymake-ruby-load)
             (diminish 'rinari-minor-mode "Ri" )
             (require 'ri)
             (message "==================== ruby-mode-hook ====================")
             )
)

;; Shell script
(setq auto-mode-alist
      (append '(("\\.sh$" . shell-script-mode)) auto-mode-alist))
(add-hook 'sh-mode-hook
      '( lambda()
         (ska-coding-keys sh-mode-map)
         (message "==================== sh-mode-hook ====================")
         )
      )

;; Lisp Mode
(add-hook 'emacs-lisp-mode-hook
      '(lambda ()
         ;; meine Keybindings
         (ska-coding-keys emacs-lisp-mode-map)
         (ska-elisp-mode-keys)
         (auto-fill-mode 1)
;emacs22             (turn-on-filladapt-mode)
         (message "==================== emacs-lisp-mode-hook ====================")
         ))

;; SQL Mode
(autoload 'sql-mode "sql" "SQL Editing Mode" t)
(setq auto-mode-alist
      (append
       '(("\\.sql$" . sql-mode))
       auto-mode-alist))
(add-hook 'sql-mode-hook
      '(lambda ()
         (ska-coding-keys sql-mode-map)
         (ska-sql-mode-keys)
         (sql-highlight-oracle-keywords)
         (message "==================== sql-mode-hook ====================")
         ))

(autoload 'gtags-mode "gtags" "" t)
(require 'auto-gtags)

(add-hook 'c-mode-common-hook
      '(lambda ()
         (require 'vvb-mode)
         (vvb-mode t)
	     (diminish 'vvb-mode)
         (imenu-add-menubar-index)
         ;; highlight self-defined types
         '(c-indent-comments-syntactically-p nil)
         (abbrev-mode 1)
         (setq tab-width 4)
         ;; explicitly load vc
         ( load-library "vc" )
;;         (setq tag-table-alist '( ("Dafit_Software/" . "/home/gru/projects/Dafit_Software/") ))
         (which-function-mode)
	     (gtags-mode t)
         (if gtags-auto-update
             (add-hook 'after-save-hook 'gtags-update-hook))
         (subword-mode t)
	     (diminish 'gtags-mode "Gtgs")
         ;;         (whitespace-mode)
         ;; (require 'doxymacs)
         ;; (doxymacs-mode)
         ;; (add-to-list 'file-name-handler-alist '("\\`/[a-zA-Z]/" . msys-file-name-handler))
         ;; (advice-add 'compilation-error-properties :around #'save-match-data-advice)

         (message "==================== c-mode-common-hook ====================")
         ))

(add-hook 'c-mode-hook
      '(lambda ()
         ;; my keybindings
         (define-key c-mode-map '[(control n) (m)]  'pt-skel-c-function)
         (ska-coding-keys c-mode-map)
         (ska-c-common-mode-keys c-mode-map)
         (setq grep-find-command '"find . \\( -name \\*.c -o -name \\*.h \\) -print0 | xargs -0 -e grep -n " )
         (font-lock-add-keywords nil
                                 '( ("\\<restrict\\>" . 'font-lock-keyword-face)))
         (setq comment-start "// " )
         (setq comment-end "" )

         (message "==================== c-mode-hook ====================")
         ))

(add-hook 'c++-mode-hook
      '(lambda ()
         ;; my keybindings
         (ska-coding-keys c++-mode-map)
         (ska-c-common-mode-keys c++-mode-map)
         (setq grep-find-command '"find . \\( -name \\*.cpp -o -name \\*.h \\) -print0 | xargs -0 -e grep -n " )
         ;; qt keywords and stuff ...
         ;; set up indenting correctly for new qt kewords
         (setq c-protection-key (concat "\\<\\(public\\|public slot\\|protected"
                        "\\|protected slot\\|private\\|private slot"
                        "\\)\\>")
           c-C++-access-key (concat "\\<\\(signals\\|public\\|protected\\|private"
                        "\\|public slots\\|protected slots\\|private slots"
                        "\\)\\>[ \t]*:"))
         ;; modify the colour of slots to match public, private, etc ...
         (font-lock-add-keywords 'c++-mode
                     '(("\\<\\(slots\\|signals\\)\\>" . font-lock-type-face)))
         ;; make new font for rest of qt keywords
         (make-face 'qt-keywords-face)
         (set-face-foreground 'qt-keywords-face "BlueViolet")
         ;; qt keywords
         (font-lock-add-keywords 'c++-mode
                     '(("\\<Q_OBJECT\\>" . 'qt-keywords-face)))
         (font-lock-add-keywords 'c++-mode
                     '(("\\<SIGNAL\\|SLOT\\>" . 'qt-keywords-face)))
         (font-lock-add-keywords 'c++-mode
                     '(("\\<Q[A-Z][A-Za-z]*" . 'qt-keywords-face)))
         ;; emacs23 (modify-syntax-entry ?_ "w" ) ; _ is part of a word
         (setq mode-name "C++")
         (message "==================== c++-mode-hook ====================")
         ) )

(setq auto-mode-alist (append '(("\\.c\.gcov$" . text-mode)) auto-mode-alist))


(add-hook 'lua-mode-hook
	  '(lambda ()
	     (message "==================== lua-mode-hook ====================")
	     ))

(add-hook 'csharp-mode-hook
          '(lambda()
             (omnisharp-mode t)
             (diminish 'omnisharp-mode "o#")
             (mg-cs-mode-keys csharp-mode-map)
             (message "==================== csharp-mode-hook ====================")
             ))



;;--------------------------------------------------------------------
;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode
;;  (global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------

(add-hook 'gnuplot-mode-hook
          '(lambda ()
             (message "==================== gnuplot-mode-hook ====================")
             ))



;;Visiting files
(require 'autoinsert)
(auto-insert-mode 1)
(setq auto-insert t )
(add-hook 'find-file-hooks 'auto-insert)

;; Writing files
(add-hook 'write-file-hooks
          '(lambda ()
             (time-stamp)
             ))

(add-hook 'speedbar-mode-hook
      '(lambda()
         (message "==================== speedbar-mode-hook start ====================")
         ( ska-speedbar-keys speedbar-key-map )
         ( setq case-fold-search t ) ; don't be case sensitive
         (message "==================== speedbar-mode-hook end ====================")
      ))

;; (add-hook 'speedbar-reconfigure-keymaps-hook
;;           '(lambda()
;;              (message "==================== speedbar-reconfigure-keymaps-hook start ====================")
;;              ( ska-speedbar-keys speedbar-key-map )
;;              (message "==================== speedbar-reconfigure-keymaps-hook end ====================")
;;           ))


;;        '(lambda ()
;;           (ska-speedbar-keys))

;; Scilab Mode
(load "scilab")
(setq auto-mode-alist (cons '("\\(\\.sci$\\|\\.sce$\\)" . scilab-mode) auto-mode-alist))
(setq scilab-mode-hook
      '(lambda ()
	 ;; my keybindings
	 (ska-coding-keys scilab-mode-map)
	 (setq fill-column 74)
	 (setq comment-start "// " )
	 (setq comment-end "" )
     (define-key scilab-mode-map (kbd "M-;") 'isearch-forward)
     (define-key scilab-mode-map (kbd "M-:") 'isearch-backward)

	 (message "==================== scilab-mode-hook ====================")
	 )
      )

;; Comint mode ( Minor interpreters, shells, gdb, ... )
(add-hook 'comint-mode-hook
      (lambda ()
;;      (load "ergonomic_keybinding_qwerty.el")
        (message "==================== comint-mode-hook ====================")))

(add-hook 'diff-mode-hook
      (lambda ()
;;      (load "ergonomic_keybinding_qwerty.el")
        (message "==================== diff-mode-hook ====================")))


;; qmake project file mode
(add-to-list 'auto-mode-alist '("\\.pro\\>" . text-mode))

;; isearch mode
(add-hook 'isearch-mode-end-hook '(lambda ()
                    (when (and isearch-forward
                           isearch-other-end)
                      (goto-char isearch-other-end))))
;; sgml mode
( add-hook 'sgml-mode-hook
       '(lambda ()
          (setq sgml-quick-keys t)
          )
       )

;; gdb mode
(add-hook 'gdb-mode-hook
      (lambda()
        (shrink-window (- (window-height) 20 ) )
        )
      )

(add-hook 'w3m-mode-hook
          (lambda()
            (vvb-mode nil )
            )
          )


(add-hook 'gtags-select-mode-hook
          (lambda()
            (define-key gtags-select-mode-map "\e*" 'gtags-pop-stack)
            (define-key gtags-select-mode-map "\C-m" 'gtags-select-tag)
            (define-key gtags-select-mode-map "\C-o" 'gtags-select-tag-other-window)
            (define-key gtags-select-mode-map "\e." 'gtags-select-tag)
            (message "==================== gtags-select-mode ====================")
            )
          )


;; ;; Prevent flyspell from finding mistakes in the code.
;; ;; From Jim Meyering.
;; (add-hook 'c-mode-hook          'flyspell-prog-mode 1)
;; (add-hook 'c++-mode-hook        'flyspell-prog-mode 1)
;; (add-hook 'cperl-mode-hook      'flyspell-prog-mode 1)
;; (add-hook 'autoconf-mode-hook   'flyspell-prog-mode 1)
;; (add-hook 'autotest-mode-hook   'flyspell-prog-mode 1)
;; (add-hook 'sh-mode-hook         'flyspell-prog-mode 1)
;; (add-hook 'makefile-mode-hook   'flyspell-prog-mode 1)
;; (add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode 1)

(require 'org-install)
 (add-to-list 'auto-mode-alist '("\\.org$" . org-mode)) ;; (4)
 (define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; (setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE")) ;; (6)
;; (setq org-agenda-include-all-todo t)
(setq org-log-done t)
;;(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)


;; emacs24 (org-remember-insinuate)
;; (define-key global-map "\C-cr" 'org-remember)

;; hippie-expand
;;expand text trying various ways to find its expansion.

(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-complete-file-name-partially
        try-expand-list
        try-complete-lisp-symbol-partially
        try-expand-line))

(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; Customisations for german calendar:

(setq calendar-time-display-form
      '(24-hours ":" minutes (and time-zone (concat " (" time-zone ")"))))

(setq calendar-day-name-array
      ["Sonntag" "Montag" "Dienstag" "Mittwoch"
       "Donnerstag" "Freitag" "Samstag"])
(setq calendar-month-name-array
      ["Januar" "Februar" "März" "April" "Mai" "Juni"
       "Juli" "August" "September" "Oktober" "November" "Dezember"])
(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

(setq christian-holidays
      '(
        (holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        ;; Date of Easter calculation taken from holidays.el.
        (let* ((century (1+ (/ displayed-year 100)))
               (shifted-epact (% (+ 14 (* 11 (% displayed-year 19))
                                    (- (/ (* 3 century) 4))
                                    (/ (+ 5 (* 8 century)) 25)
                                    (* 30 century))
                                 30))
               (adjusted-epact (if (or (= shifted-epact 0)
                                       (and (= shifted-epact 1)
                                            (< 10 (% displayed-year 19))))
                                   (1+ shifted-epact)
                                 shifted-epact))
               (paschal-moon (- (calendar-absolute-from-gregorian
                                 (list 4 19 displayed-year))
                                adjusted-epact))
               (easter (calendar-dayname-on-or-before 0 (+ paschal-moon 7))))
          (filter-visible-calendar-holidays
           (mapcar
            (lambda (l)
              (list (calendar-gregorian-from-absolute (+ easter (car l)))
                    (nth 1 l)))
            '(
              ;;(-48 "Rosenmontag")
              ( -2 "Karfreitag")
              (  0 "Ostersonntag")
              ( +1 "Ostermontag")
              (+39 "Christi Himmelfahrt")
              (+49 "Pfingstsonntag")
              (+50 "Pfingstmontag")
              (+60 "Fronleichnam")
             ))))
        (holiday-fixed 8 15 "Mariä Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        ;;(holiday-float 11 3 1 "Buß- und Bettag" 16)
        (holiday-float 11 0 1 "Totensonntag" 20)))

;(setq calendar-holidays
;      (append general-holidays local-holidays other-holidays
;              christian-holidays solar-holidays));




;; tiny stuff
;; no splash screen
(setq-default inhibit-startup-message t)
;; y instead of  y e s  is enough
(fset 'yes-or-no-p 'y-or-n-p)
;; file name in icon
(setq frame-title-format (list mode-line-buffer-identification))
;; Timestamp within the first 8(?) lines
;; Format: Time-stamp: <>
(setq time-stamp-active t)
(setq time-stamp-format "%02d-%3b-%:y %02H:%02M:%02S %u")
;; für Menueintrag Edit->Text Properties
(require 'facemenu)

(require 'shebang)

( setenv "GREP_OPTIONS" "--color=never" )

;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

;; (add-hook 'latex-mode-hook 'turn-on-reftex)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-auctex t)

;; ;; (setq TeX-parse-self t) ; Enable parse on load.
;; ;; (setq TeX-auto-save t) ; Enable parse on save.

;; ;; (add-hook 'TeX-language-de-hook
;; ;;            (lambda () (ispell-change-dictionary "german")))


(defadvice vc-revert-buffer (after touch activate)
  "Reset the visited file's modification time to the current time."
  (shell-command (format "touch %s" buffer-file-name)))

;; Filesets "remember" files for quick access
(filesets-init)

;; Start emacs server so you can use emacsclient
(server-start)

;; menu bar takes only place
(menu-bar-mode 0)
(scroll-bar-mode 0)
(horizontal-scroll-bar-mode 0)

(when (require 'sml-modeline nil 'noerror)
  (sml-modeline-mode 1 ) )

;; w3m browser
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)


;;
;; Font locking in buffer menu (M-S-y / buffer-menu)
;;
;; (setq buffer-menu-buffer-font-lock-keywords
;;       '(("^....[*]Man .*Man.*"   . font-lock-variable-name-face) ;Man page
;;         (".*Dired.*"             . font-lock-comment-face)       ; Dired
;;         ("^....[*]shell.*"       . font-lock-preprocessor-face)  ; shell buff
;;         (".*[*]scratch[*].*"     . font-lock-function-name-face) ; scratch buffer
;;         ("^....[*].*"            . font-lock-string-face)        ; "*" named buffers
;;         ("^..[*].*"              . font-lock-constant-face)      ; Modified
;;         ("^.[%].*"               . font-lock-keyword-face)))     ; Read only

;; (defun buffer-menu-custom-font-lock  ()
;;   (let ((font-lock-unfontify-region-function
;;          (lambda (start end)
;;            (remove-text-properties start end '(font-lock-face nil)))))
;;     (font-lock-unfontify-buffer)
;;     (set (make-local-variable 'font-lock-defaults)
;;          '(buffer-menu-buffer-font-lock-keywords t))
;;     (font-lock-fontify-buffer)))

;; (add-hook 'buffer-menu-mode-hook 'buffer-menu-custom-font-lock)

;; ------------------------------
;; (require 'skype)
;; (setq skype--my-user-handle "markus.grunwald-pt-skype")
;; ------------------------------

;;
;; wide cursor bar (spans a whole line)
;; something always turns this off again :(
;;
( global-hl-line-mode 1 )

;; -- auto complete
(if (< emacs-major-version 24 )
    (progn
      (require 'auto-complete)
      (add-to-list 'ac-dictionary-directories "/usr/share/auto-complete/dict/")
      (require 'auto-complete-config)
      (ac-config-default)

      (autoload 'po-mode "po-mode"
	"Major mode for translators to edit PO files" t)
      (setq auto-mode-alist (cons '("\\.po\\'\\|\\.po\\." . po-mode)
				  auto-mode-alist))
      (autoload 'po-find-file-coding-system "po-compat")
      (modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
				  'po-find-file-coding-system)
      (diminish 'auto-complete-mode)
      )
  )
;;
;; ruby
;;
;; (load "/usr/local/share/emacs/site-lisp/nxhtml/autostart.el")
;; (defun ruby-insert-end ()
;;   "Insert \"end\" at point and reindent current line."
;;   (interactive)
;;   (insert "end")
;;   (ruby-indent-line t)
;;   (end-of-line))

;; (require 'rinari)
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (defadvice ruby-mode-set-encoding
;;               (around ruby-mode-set-encoding-disable activate) nil)))
;; (require 'ruby-electric)
;; (add-hook 'ruby-mode-hook 'ruby-electric-mode)

;;(require 'mumamo-fun)
;;(setq mumamo-chunk-coloring 5)
;;(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
;;(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))

;; Workaround the annoying warnings:
;; Warning (mumamo-per-buffer-local-vars):
;; Already 'permanent-local t: buffer-file-name
;; (when (and (equal emacs-major-version 24)
;;            (equal emacs-minor-version 3))
;;   (eval-after-load "mumamo"
;;     '(setq mumamo-per-buffer-local-vars
;;            (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; (require 'rails)

;;
;; web mode (untested)
;;

(when (require 'web-mode nil 'noerror)
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb$" . web-mode)) ;; (4)
  )

;; Interactively Do Things (highly recommended, but not strictly required)
;; http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
(require 'ido)
(ido-mode t)
;;
;; full-ack: http://nschum.de/src/emacs/full-ack/
;;
(add-to-list 'load-path "/path/to/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;;
;; Bookmark+
;;
(require 'bookmark+)
(edit-bookmarks)
(switch-to-buffer "*Bookmark List*")

(require 'smooth-scrolling)

(require 'grep-edit)

;;
;; Magit: enable svn extensions
;; Disabled because it leads to strange "unpulled commits (svn)"
;;  messages that I don't untderstand. I have no unpulled commits.)
;; Later: Ok, I /had/ unpulled commits in the branch.
;;
;; (add-hook 'magit-mode-hook 'turn-on-magit-svn)

;;
;; diminish.el: get a shorter modeline
;;
(diminish 'abbrev-mode)
(diminish 'auto-fill-function)
(diminish 'flymake-mode "FlyMk")


;;
;; octave
;;
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (setq comment-start "%" )
            ))

;; And finally, inferior-octave-mode-hook is run after starting the process
;; and putting its buffer into Inferior Octave mode. Hence, if you like
;; the up and down arrow keys to behave in the interaction buffer as in
;; the shell, and you want this buffer to use nice colors:

(add-hook 'inferior-octave-mode-hook
          (lambda ()
            (turn-on-font-lock)
            (define-key inferior-octave-mode-map [up]
              'comint-previous-input)
            (define-key inferior-octave-mode-map [down]
              'comint-next-input)))

;;
;; IDO Mode
;;
(ido-mode 1)

;;
;; Markdown Mode
;;
(setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))


(autoload 'octave-help "octave-hlp" nil t)

;;(speedbar-get-focus)

;; (setq org-latex-to-pdf-process
;;   '("xelatex -interaction nonstopmode %f"
;;      "xelatex -interaction nonstopmode %f")) ;; for multiple passes


;;
;; Auto inserts
;;
(add-to-list 'auto-insert-alist
        '((perl-mode . "Perl Program")
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
        )

(add-to-list 'auto-insert-alist  '((org-mode . "org mode" )
         nil
         "#+OPTIONS:    H:3 num:nil toc:t \\n:nil @:t ::t |:t ^:t -:t f:t *:t TeX:t LaTeX:t skip:nil d:(HIDE) tags:not-in-toc\n"
         "#+STARTUP:    align fold nodlcheck hidestars oddeven lognotestate\n"
         "#+SEQ_TODO:   TODO(t) INPROGRESS(i) WAITING(w@) | DONE(d) CANCELED(c@)\n"
         "#+TAGS:       telephon(t) kaufen(k) brief(b)\n"
         "#+TITLE:      \n"
         "#+AUTHOR:     "(user-full-name)"\n"
         "#+EMAIL:      "(progn user-mail-address)"\n"
         "#+LANGUAGE:   en\n\n" _
         ) )

(add-to-list 'auto-insert-alist
        '(("\\.sh$" . "Shell script")
         nil
         "#!/bin/bash\n"
         "##############################################################################\n"
         "# @file "(file-name-nondirectory buffer-file-name)"\n"
         "#\n\n"
         "# Time-stamp: <>\n#\n"
         "# Author: "(user-full-name) "\n#\n\n"
         "# Let shell functions inherit ERR trap.  Same as `set -E'.\n"
         "set -o errtrace \n\n"
         "# Trigger error when expanding unset variables.  Same as `set -u'.\n"
         "set -o nounset\n\n"
         "#  Trap non-normal exit signals: 1/HUP, 2/INT, 3/QUIT, 15/TERM, ERR\n"
         "#  NOTE1: - 9/KILL cannot be trapped.\n"
         "#        - 0/EXIT isn't trapped because:\n"
         "#          - with ERR trap defined, trap would be called twice on error\n"
         "#          - with ERR trap defined, syntax errors exit with status 0, not 2\n"
         "#  NOTE2: Setting ERR trap does implicit `set -o errexit' or `set -e'.\n"
         "trap quit 1 2 3 15 ERR\n"
         "\n"
         "\n"
         "#--- quit() -----------------------------------------------------\n"
         "#  @param $1 integer  (optional) Exit status.  If not set, use `$?'\n"
         "#  @param $2 message  (optional) Error/exit message\n"
         "#\n"
         "#  Use \"quit\" instead of \"exit\" to cleanly quit this script\n"
         "#  Allways call `quit' at end of script\n"
         "\n"
         "function quit() {\n"
         "    local exit_status=${1:-$?}\n"
         "    local message=${2:-\"\"}\n"
         "    [ -n \"${message}\"    ] && echo \"${message}\"\n"
         "    [ ${exit_status} -ne 0 ] && echo Exiting $0 with status $exit_status\n"
         "    exit $exit_status\n"
         "}\n"
         "\n"
         "\n"
         "\n"
         "# myscript" _ "\n"
         "\n"
         "\n"
         "\n"
         "# Allways call `quit' at end of script\n"
         "quit\n"
         ;; (progn (save-buffer)
         ;;        (shell-command (format "chmod +x %s"
         ;;                               (buffer-file-name))
         ;;                       )
         ;;        "")
         ))
;; Rinari
(require 'rinari nil 'noerror)

(require 'autopair nil 'noerror)
(autopair-global-mode)
(diminish 'autopair-mode "pr")

(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"

               "<!--"
               sgml-skip-tag-forward
               nil))

(add-hook 'nxml-mode-hook 'hs-minor-mode)

;; optional key bindings, easier than hs defaults
(define-key nxml-mode-map (kbd "C-c h") 'hs-toggle-hiding)

;; (smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
;;                        'ruby 'nxml)

;; To parse "IAR Embedded workbench 4.21A for Atmel AVR" messages
;; Load compile.el library
;; seen at https://lists.gnu.org/archive/html/help-gnu-emacs/2008-09/msg00687.html
(require 'compile)
;;Store new item "iar-avr" into compilation-error-regexp-alist variable
(setq compilation-error-regexp-alist
      (cons 'iar-avr compilation-error-regexp-alist))
;; Store iar-avr regexp into compilation-error-regexp-alist-alist variable
(setq compilation-error-regexp-alist-alist
      (cons '(iar-avr
              "^\\(?:.*\\\\\\)\\(.*\\)(\\([0-9]+\\)) : \\(?:Error\\|Warnin\\(g\\)\\)\\[Pe[0-9]+\\]:"
              1 2 nil (3)) compilation-error-regexp-alist-alist))
;;
;; "Instead of setq you may want to use custom-set-variable"

;; yang
(autoload 'yang-mode "yang-mode" "Major mode for editing YANG modules."
  t)
(add-to-list 'auto-mode-alist '("\\.yang$" . yang-mode))

(defun my-compilation-mode-hook ()
  (setq truncate-lines nil) ;; automatically becomes buffer local
  (set (make-local-variable 'truncate-partial-width-windows) nil))
(add-hook 'compilation-mode-hook 'my-compilation-mode-hook)

;; http://stackoverflow.com/questions/9656311/conflict-resolution-with-emacs-ediff-how-can-i-take-the-changes-of-both-version
(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)

(if (fboundp 'google-this-mode) (google-this-mode 1) )
(diminish 'google-this-mode)



;; Horizontal splitting really ought to be the default, honestly.
(setq ediff-split-window-function 'split-window-horizontally)
(add-to-list 'file-name-handler-alist '("\\`/[a-zA-Z]/" . msys-file-name-handler))
(advice-add 'compilation-error-properties :around #'save-match-data-advice)

;;Let the frame show the current desktop
;; https://emacs.stackexchange.com/questions/33708/what-is-missing-to-show-the-desktop-dirname-in-the-frame-title
(setq frame-title-format `( ,( file-name-nondirectory (directory-file-name desktop-dirname) )
                           ":  %b " ) )

(message "personal.el done")
