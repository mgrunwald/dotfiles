;;; personal.el --- Setup modes, hooks and other personal stuff

(defvar my-lisp-dir
  (concat my-emacs-dir "lisp/")
  "The personal lisp directory. All self-written files and files from
the web goe here. Larger packages like e.g. VM or PSGML are installed
in subdirs."
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Setting paths and list

(setq load-path
      (append
       (list
        my-config-dir
        my-templates-dir
        my-lisp-dir
        ;;(concat my-lisp-dir "psgml-1.2.2")
        (concat my-lisp-dir "tools")
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


;;{{{ The settings of the new filenames for some packages
(setq vm-init-file            (concat my-config-dir "/vm-init.el"))
(setq gnus-init-file          (concat my-config-dir "/gnus.el"))
(setq save-place-file         (concat my-data-dir   "/places.el"))
(setq recent-files-save-file  (concat my-data-dir       "/recent-files.el"))
(setq bbdb-file               (concat my-data-dir   "/bbdb"))
;; uhm what exactly is this??
(setq shadow-info-file        (concat my-data-dir   "/shadows"))
(setq shadow-todo-file        (concat my-data-dir   "/shadow_todo"))
;;}}}


(load "kicking-the-habbit.el" )
(load "ergonomic_keybinding_qwerty.el")
(require 'ska-global-keys)
(require 'ska-local-keys)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Modes

(add-hook 'before-save-hook
          '(lambda ()
             (whitespace-cleanup)
             )
          )


(add-hook 'text-mode-hook
          '(lambda ()
             (auto-fill-mode 1)
;emacs22             (turn-on-filladapt-mode)
             (abbrev-mode 1)
             (load "ergonomic_keybinding_qwerty.el")
             (message "==================== text-mode-hook ====================")
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

(add-hook 'c-mode-common-hook
          '(lambda ()
;emacs22             (require 'ctypes)
             (require 'vvb-mode)
             (imenu-add-menubar-index)
             ;; highlight self-defined types
;emacs22             (ctypes-auto-parse-mode 1)
             '(c-indent-comments-syntactically-p nil)
             (abbrev-mode 1)
             (auto-fill-mode 1)
             (setq fill-column 90)
             (setq tab-width 4)
             ;; explicitly load vc
             ( load-library "vc" )
             (setq tag-table-alist '( ("Dafit_Software/" . "/home/gru/projects/Dafit_Software/") ))
             (which-function-mode)
             (message "==================== c-mode-common-hook ====================")
             ))

(add-hook 'c-mode-hook
          '(lambda ()
             ;; my keybindings
             (ska-coding-keys c-mode-map)
             (ska-c-common-mode-keys c-mode-map)
             (setq grep-find-command '"find . \\( -name \\*.c -o -name \\*.h \\) -print0 | xargs -0 -e grep -n " )
             (message "==================== c-mode-hook ====================")
             ))

(add-hook 'c++-mode-hook
          '(lambda ()
             ;; my keybindings
             (ska-coding-keys c++-mode-map)
             (ska-c-common-mode-keys c++-mode-map)
             (require 'doxymacs)
             (doxymacs-mode)
;;              (setq comment-start "// " )
;;              (setq comment-end "" )
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
             (modify-syntax-entry ?_ "w" ) ; _ is part of a word
             (message "==================== c++-mode-hook ====================")
             ) )

(setq auto-mode-alist
	  (append
	   '(("\\.gp$" . gnuplot-mode)
		 ("\\.gnu$" . gnuplot-mode))
	   auto-mode-alist))
(add-hook 'gnuplot-mode-hook
		  '(lambda ()
			 ;; meine Keybindings
			 (ska-coding-keys gnuplot-mode-map)
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


;; 		  '(lambda ()
;; 			 (ska-speedbar-keys))

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
         (message "==================== scilab-mode-hook ====================")
         )
      )

;; Comint mode ( Minor interpreters, shells, gdb, ... )
(add-hook 'comint-mode-hook
          (lambda ()
            (load "ergonomic_keybinding_qwerty.el")
            (message "==================== comint-mode-hook ====================")))



;;
(load "wide-edit.el")
;;(wide-edit-insinuate-grep 't)

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

;; autoinsert.el
;; automatic insertion of text into new files.
;; Find appropriate skeletons for various modes.
;; this just shows the syntax
(load "pt-auto-insert" nil nil nil)



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

;; Start emacs server so you can use emacsclient
(server-start)
