;;; Code:

;;; Link this file to ~/.emacs

;; This directory contains all the xemacs relevant stuff:
(defvar my-emacs-dir
  (expand-file-name "~/.emacs.d/my/")
"The directory where all the Emacs configuration (and more) goes."
  )

(defun region-active-p ()
  "Say whether the region is active."
  (and (boundp 'transient-mark-mode)
       transient-mark-mode
       (boundp 'mark-active)
       mark-active))

(defun region-exists-p ()
  "Non-nil means the mark and region are currently active in this buffer."
  mark-active) ; aliased to region-exists-p in XEmacs.

(defun replace-in-string (string regexp newtext &optional literal)
      (let ((start 0) tail)
        (while (string-match regexp string start)
          (setq tail (- (length string) (match-end 0)))
          (setq string (replace-match newtext nil literal string))
          (setq start (- (length string) tail))))
      string)

;;============================================================================
;;{{{ Custom Settings


;;}}} End of Custom Settings
;;============================================================================

;;============================================================================
;;{{{ Personal Settings
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; I´m getting tired of dealing with options and custom and getting my
;; customizations messed up. So I put them all in an extra file, which 
;; gets loaded here
(load (concat my-emacs-dir "config/personal.el") nil nil 1)
;;}}}
;;============================================================================

(setq abbrev-file-name             ;; tell emacs where to read abbrev
      "~/.emacs.d/my/config/abbrev_defs.el")    ;; definitions from...
(read-abbrev-file abbrev-file-name t)


;(set-face-background 'default' "white" )
;(set-face-background 'buffers-tab' "Gray90" )
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(Info-auto-generate-directory (quote if-outdated))
 '(Info-button1-follows-hyperlink t)
 '(Info-save-auto-generated-dir (quote always))
 '(TeX-close-quote "\"'")
 '(TeX-open-quote "\"`")
 '(all-christian-calendar-holidays t t)
 '(bar-cursor (quote (quote other)))
 '(browse-url-browser-function (quote browse-url-firefox-new-tab) t)
 '(browse-url-galeon-new-window-is-tab t)
 '(buffers-menu-max-size nil)
 '(c-basic-offset 4)
 '(c-default-style (quote ((java-mode . "java") (other . "gnu"))))
 '(c-echo-syntactic-information-p nil)
 '(c-label-minimum-indentation 0)
 '(c-offsets-alist (quote ((substatement-open . 0) (case-label . +))))
 '(calc-gnuplot-name "gnuplot" t)
 '(calendar-latitude [48 8 north] t)
 '(calendar-longitude [11 43 east] t)
 '(calendar-week-start-day 1 t)
 '(case-fold-search t)
 '(cc-other-file-alist (quote (("\\.cc$" (".hh" ".h")) ("\\.hh$" (".cc" ".C")) ("\\.c$" (".h")) ("\\.h$" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp")) ("\\.C$" (".H" ".hh" ".h")) ("\\.H$" (".C" ".CC")) ("\\.CC$" (".HH" ".H" ".hh" ".h")) ("\\.HH$" (".CC")) ("\\.cxx$" (".hh" ".h")) ("\\.cpp$" (".h" ".hh")))))
 '(change-log-default-name "~/ChangeLog.Work")
 '(column-number-mode t)
 '(compilation-ask-about-save nil)
 '(compilation-read-command nil)
 '(compilation-scroll-output t)
 '(compilation-window-height 15)
 '(compile-command "NetMake -k -j9")
 '(current-language-environment "Latin-1")
 '(dabbrev-case-fold-search nil)
 '(dabbrev-case-replace nil)
 '(debug-on-error nil)
 '(default-input-method "latin-1-prefix")
 '(diff-switches "-u" t)
 '(doxymacs-doxygen-dirs (quote (("/home/gru/projects/vxp/trunk" "/home/gru/doc/dafit/trunk/dafit.xml" "file:///home/gru/doc/dafit/trunk/html") ("/home/gru/projects/vxp/branches" "/home/gru/doc/dafit/trunk/dafit.xml" "file:///home/gru/doc/dafit/trunk/html"))))
 '(doxymacs-use-external-xml-parser t)
 '(ediff-use-toolbar-p t)
 '(efs-ftp-program-args (quote ("-i" "-n" "-g" "-v" "-p")))
 '(european-calendar-style t t)
 '(ff-ignore-include t)
 '(find-file-compare-truenames t)
 '(fume-max-items 50)
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t nil (hl-line))
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(gutter-buffers-tab-visible-p nil)
 '(home-end-enable nil)
 '(imenu-sort-function (quote imenu--sort-by-name))
 '(indent-tabs-mode nil)
 '(ispell-dictionary-alist (quote ((nil "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-B") nil iso-8859-1) ("american" "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-B") nil iso-8859-1) ("brasileiro" "[A-ZÁÉÍÓÚÀÈÌÒÙÃÕÇÜÂÊÔa-záéíóúàèìòùãõçüâêô]" "[^A-ZÁÉÍÓÚÀÈÌÒÙÃÕÇÜÂÊÔa-záéíóúàèìòùãõçüâêô]" "[']" nil ("-d" "brasileiro") nil iso-8859-1) ("british" "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-B" "-d" "british") nil iso-8859-1) ("castellano" "[A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[^A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[-]" nil ("-B" "-d" "castellano") "~tex" iso-8859-1) ("castellano8" "[A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[^A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[-]" nil ("-B" "-d" "castellano") "~latin1" iso-8859-1) ("czech" "[A-Za-zÁÉÌÍÓÚÙİ®©ÈØÏ«Òáéìíóúùı¾¹èøï»ò]" "[^A-Za-zÁÉÌÍÓÚÙİ®©ÈØÏ«Òáéìíóúùı¾¹èøï»ò]" "" nil ("-B" "-d" "czech") nil iso-8859-2) ("dansk" "[A-ZÆØÅa-zæøå]" "[^A-ZÆØÅa-zæøå]" "[']" nil ("-C") nil iso-8859-1) ("deutsch" "[a-zA-Z\"]" "[^a-zA-Z\"]" "[']" t ("-C") "~tex" iso-8859-1) ("deutsch8" "[a-zA-ZÄÖÜäößü]" "[^a-zA-ZÄÖÜäößü]" "[']" t ("-C" "-d" "deutsch") "~latin1" iso-8859-1) ("english" "[A-Za-z]" "[^A-Za-z]" "[']" nil ("-B") nil iso-8859-1) ("esperanto" "[A-Za-z¦¬¶¼ÆØİŞæøış]" "[^A-Za-z¦¬¶¼ÆØİŞæøış]" "[-']" t ("-C") "~latin3" iso-8859-1) ("esperanto-tex" "[A-Za-z^\\]" "[^A-Za-z^\\]" "[-'`\"]" t ("-C" "-d" "esperanto") "~tex" iso-8859-1) ("francais7" "[A-Za-z]" "[^A-Za-z]" "[`'^---]" t nil nil iso-8859-1) ("francais" "[A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü]" "[^A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü]" "[-']" t nil "~list" iso-8859-1) ("francais-tex" "[A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü\\]" "[^A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü\\]" "[-'^`\"]" t nil "~tex" iso-8859-1) ("ogerman" "[a-zA-Z\"]" "[^a-zA-Z\"]" "[']" t ("-C") "~tex" iso-8859-1) ("ogerman8" "[a-zA-ZÄÖÜäößü]" "[^a-zA-ZÄÖÜäößü]" "[']" t ("-C" "-d" "ogerman") "~latin1" iso-8859-1) ("italiano" "[A-ZÀÁÈÉÌÍÒÓÙÚa-zàáèéìíóùú]" "[^A-ZÀÁÈÉÌÍÒÓÙÚa-zàáèéìíóùú]" "[-]" nil ("-B" "-d" "italian") "~tex" iso-8859-1) ("nederlands" "[A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[^A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[']" t ("-C") nil iso-8859-1) ("nederlands8" "[A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[^A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[']" t ("-C") nil iso-8859-1) ("norsk" "[A-Za-zÅÆÇÈÉÒÔØåæçèéòôø]" "[^A-Za-zÅÆÇÈÉÒÔØåæçèéòôø]" "[\"]" nil ("-d" "norsk") "~list" iso-8859-1) ("norsk7-tex" "[A-Za-z{}\\'^`]" "[^A-Za-z{}\\'^`]" "[\"]" nil ("-d" "norsk") "~plaintex" iso-8859-1) ("polish" "[A-Za-z¡£¦¬¯±³¶¼¿ÆÊÑÓæêñó]" "[^A-Za-z¡£¦¬¯±³¶¼¿ÆÊÑÓæêñó]" "" nil ("-d" "polish") nil iso-8859-2) ("russian" "[áâ÷çäå³öúéêëìíîïğòóôõæèãşûıøùÿüàñÁÂ×ÇÄÅ£ÖÚÉÊËÌÍÎÏĞÒÓÔÕÆÈÃŞÛİØÙßÜÀÑ]" "[^áâ÷çäå³öúéêëìíîïğòóôõæèãşûıøùÿüàñÁÂ×ÇÄÅ£ÖÚÉÊËÌÍÎÏĞÒÓÔÕÆÈÃŞÛİØÙßÜÀÑ]" "" nil ("-d" "russian") nil koi8-r) ("svenska" "[A-Za-zåäöéàüèæøçÅÄÖÉÀÜÈÆØÇ]" "[^A-Za-zåäöéàüèæøçÅÄÖÉÀÜÈÆØÇ]" "[']" nil ("-C") "~list" iso-8859-1) ("portugues" "[a-zA-ZÁÂÉÓàáâéêíóãú]" "[^a-zA-ZÁÂÉÓàáâéêíóãú]" "[']" t ("-C" "-d" "portugues") "~latin1" iso-8859-1) ("slovak" "[A-Za-zÁÄÉÍÓÚÔÀÅ¥İ®©ÈÏ«Òáäéíóúôàåµı¾¹èï»ò]" "[^A-Za-zÁÄÉÍÓÚÔÀÅ¥İ®©ÈÏ«Òáäéíóúôàåµı¾¹èï»ò]" "" nil ("-B" "-d" "slovak") nil iso-8859-2))) t)
 '(ispell-local-dictionary "british")
 '(kill-whole-line t)
 '(lazy-lock-stealth-time 60)
 '(line-number-mode t)
 '(make-tags-files-invisible t)
 '(mark-diary-entries-in-calendar t t)
 '(mark-holidays-in-calendar t t)
 '(minibuffer-electric-file-name-behavior t nil (minibuf-electric))
 '(mode-compile-always-save-buffer-p t)
 '(mode-compile-never-edit-command-p t)
 '(modifier-keys-are-sticky nil)
 '(modifier-keys-sticky-time 750 t)
 '(mouse-wheel-mode t nil (mwheel))
 '(mouse-yank-at-point t)
 '(paren-mode (quote blink-paren) nil (paren))
 '(preview-default-document-pt 12)
 '(printer-name "kopierer")
 '(ps-paper-type (quote a4))
 '(ps-print-color-p nil)
 '(recent-files-commands-submenu t)
 '(recent-files-dont-include (quote ("~$" "Guinan/." "INBOX" ".bbdb" ".newsrc." "places.el" "^moc_.*" "\\.cache" "TAGS")))
 '(recent-files-filename-replacements (quote (("/home/gru/projects/vxp/trunk" . "trunk") ("/mnt/ext1/home/gru" . "~") ("/home/gru" . "~") ("/home/gru/projects/vxp/branches" . "branches"))))
 '(recent-files-non-permanent-submenu nil)
 '(recent-files-number-of-entries 10)
 '(recent-files-number-of-saved-entries 10)
 '(recent-files-permanent-submenu t)
 '(recent-files-sort-function (quote recent-files-sort-alphabetically))
 '(recent-files-use-full-names t)
 '(recentf-mode t nil (recentf))
 '(require-final-newline (quote ask))
 '(save-place t nil (saveplace))
 '(scroll-margin 3)
 '(show-paren-mode t nil (paren))
 '(signal-error-on-buffer-boundary nil)
 '(speedbar-directory-button-trim-method (quote trim))
 '(speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.svn\\)\\'")
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 36) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t))))
 '(speedbar-frame-plist (quote (minibuffer nil width 37 border-width 0 internal-border-width 0 unsplittable t default-toolbar-visible-p nil has-modeline-p nil menubar-visible-p nil default-gutter-visible-p nil)))
 '(speedbar-show-unknown-files t)
 '(speedbar-supported-extension-expressions (quote (".bnf" ".pro" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java" ".f\\(90\\|77\\|or\\)?" ".ada" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py" ".s?html" "[Mm]akefile\\(\\.in\\)?")))
 '(tab-width 4)
 '(tags-always-exact t)
 '(tags-auto-read-changed-tag-files t)
 '(tags-check-parent-directories-for-tag-files nil)
 '(tags-exuberant-ctags-optimization-p t)
 '(tex-close-quote "\"'" t)
 '(tex-open-quote "\"`" t)
 '(toolbar-visible-p nil)
 '(tooltip-gud-tips-p t)
 '(track-eol t)
 '(transient-mark-mode t)
 '(truncate-lines t)
 '(undo-high-threshold 300000)
 '(undo-threshold 200000)
 '(url-be-asynchronous t)
 '(url-news-server nil)
 '(url-personal-mail-address nil)
 '(url-privacy-level (quote paranoid))
 '(url-proxy-services (quote (("no_proxy" . "\\(localhost\\)") ("http" . "172.17.5.46:8000"))))
 '(url-show-status nil)
 '(url-use-hypertext-gopher nil)
 '(user-mail-address "markus.grunwald@pruftechnik.com")
 '(vc-mode-face (quote highlight))
 '(visible-bell t)
 '(vvb-column 100 t)
 '(vvb-mode t t)
 '(vvb-right-on-eol-p t t)
 '(w3-default-homepage "file:///home/gru/doc/dafit/1.50/html/index.html")
 '(w3-delay-image-loads t)
 '(w3-do-incremental-display t)
 '(w3-icon-format nil)
 '(w3-maximum-line-length 100)
 '(w3-min-img-size 5)
 '(whitespace-auto-cleanup t)
 '(woman-cache-filename "~/.emacs.d/woman-cache.el
")
 '(woman-imenu t)
 '(woman-use-own-frame nil))


(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 116 :width normal :family "Profont"))))
 '(cursor ((t (:background "blue"))))
 '(highlight ((((class color) (background light)) (:background "gray95"))))
 '(mode-line ((((type x w32 mac) (class color)) (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button) :height 100)))))

;;============================================================================                                                                                           ;;{{{ Desktop for saving whole sessions
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; this should be near the end of my .xemacs-options
(desktop-load-default)
(add-hook 'kill-emacs-hook 
          '(lambda ()
                (desktop-truncate search-ring 3)
                (desktop-truncate regexp-search-ring 3)))
(desktop-read)
;;}}}
;;============================================================================


(put 'narrow-to-region 'disabled nil)
