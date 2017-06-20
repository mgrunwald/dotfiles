(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-buffer+size-width 40)
 '(Buffer-menu-mode-width 8)
 '(Info-additional-directory-list (quote ("c:\\cygwin64\\usr\\share\\info\\")))
 '(Info-auto-generate-directory (quote if-outdated))
 '(Info-button1-follows-hyperlink t)
 '(Info-save-auto-generated-dir (quote always))
 '(LaTeX-command "pdflatex -shell-escape")
 '(TeX-close-quote "\"'")
 '(TeX-command-list
   (quote
    (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("XeLaTeX" "xelatex -interaction nonstopmode %t" TeX-run-TeX nil
      (latex-mode doctex-mode))
     ("Makeinfo" "makeinfo %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
     ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
     ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-master t)
 '(TeX-open-quote "\"`")
 '(TeX-quote-language-alist (quote (("" "``" "''" t) ("german" "\"`" "\"'" t))))
 '(ange-ftp-try-passive-mode t)
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-hscroll-mode t)
 '(auto-update (quote all))
 '(bar-cursor (quote (quote other)))
 '(before-save-hook (quote (time-stamp delete-trailing-whitespace)))
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(browse-url-browser-function (quote browse-url-default-windows-browser))
 '(buffers-menu-max-size nil)
 '(c-basic-offset 4)
 '(c-default-style (quote ((java-mode . "java") (other . "gnu"))))
 '(c-echo-syntactic-information-p nil)
 '(c-label-minimum-indentation 0)
 '(c-offsets-alist
   (quote
    ((brace-list-open . 0)
     (statement-case-open . 0)
     (substatement-open . 0)
     (case-label . +))))
 '(calc-gnuplot-name "gnuplot")
 '(calendar-date-style (quote european))
 '(calendar-latitude 48.1)
 '(calendar-longitude 11.6)
 '(calendar-mark-diary-entries-flag t)
 '(calendar-mark-holidays-flag t)
 '(calendar-week-start-day 1)
 '(case-fold-search t)
 '(cc-other-file-alist
   (quote
    (("\\.cc$"
      (".hh" ".h"))
     ("\\.hh$"
      (".cc" ".C"))
     ("\\.c$"
      (".h"))
     ("\\.h$"
      (".c" ".cc" ".C" ".CC" ".cxx" ".cpp"))
     ("\\.C$"
      (".H" ".hh" ".h"))
     ("\\.H$"
      (".C" ".CC"))
     ("\\.CC$"
      (".HH" ".H" ".hh" ".h"))
     ("\\.HH$"
      (".CC"))
     ("\\.cxx$"
      (".hh" ".h"))
     ("\\.cpp$"
      (".h" ".hh")))))
 '(change-log-default-name "~/ChangeLog.Work")
 '(column-number-mode t)
 '(company-auto-complete (quote (quote company-explicit-action-p)))
 '(company-show-numbers t)
 '(compilation-ask-about-save nil)
 '(compilation-read-command nil)
 '(compilation-scroll-output t)
 '(compilation-window-height 15)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("d6a00ef5e53adf9b6fe417d2b4404895f26210c52bb8716971be106550cea257" default)))
 '(cygwin-mount-cygwin-bin-directory "C:/cygwin64/bin")
 '(cygwin-mount-table t)
 '(dabbrev-case-fold-search nil)
 '(dabbrev-case-replace nil)
 '(debug-on-error nil)
 '(default-input-method "latin-1-prefix")
 '(desktop-save (quote ask))
 '(desktop-save-mode t)
 '(diary-display-function (quote diary-simple-display))
 '(diary-file "~/org/diary")
 '(diary-list-entries-hook (quote (diary-sort-entries)))
 '(diff-switches "-u")
 '(dmoccur-exclusion-mask
   (quote
    ("\\.elc$" "\\.exe$" "\\.dll$" "\\.lib$" "\\.lzh$" "\\.zip$" "\\.deb$" "\\.gz$" "\\.pdf$" "\\.tar$" "\\.gz$" "\\.7z$" "\\.o$" "\\.a$" "\\.mod$" "\\.nc$" "\\.obj$" "\\.ai$" "\\.fla$" "\\.swf$" "\\.dvi$" "\\.pdf$" "\\.bz2$" "\\.tgz$" "\\.cab$" "\\.sea$" "\\.bin$" "\\.fon$" "\\.fnt$" "\\.scr$" "\\.tmp$" "\\.wrl$" "\\.Z$" "\\.aif$" "\\.aiff$" "\\.mp3$" "\\.wma$" "\\.mpg$" "\\.mpeg$" "\\.aac$" "\\.mid$" "\\.au$" "\\.avi$" "\\.dcr$" "\\.dir$" "\\.dxr$" "\\.midi$" "\\.mov$" "\\.ra$" "\\.ram$" "\\.vdo$" "\\.wav$" "\\.doc$" "\\.xls$" "\\.ppt$" "\\.mdb$" "\\.adp$" "\\.wri$" "\\.jpg$" "\\.gif$" "\\.tiff$" "\\.tif$" "\\.bmp$" "\\.png$" "\\.pbm$" "\\.jpeg$" "\\.xpm$" "\\.pbm$" "\\.ico$" "\\.eps$" "\\.psd$" "/TAGS$" "\\~$" "\\.svn/.+" "CVS/.+" "\\.git/.+" "\\.pbi$" "\\.cout$" "\\.pbd$" "\\.browse$" "GPATH$" "GRTAGS$" "GTAGS$" "\\.gcov$")))
 '(doxymacs-doxygen-dirs
   (quote
    (("^c:/ST_M4_Lib/" "c:/ST_M4_Lib/STM32F30x_StdPeriph_Driver/doxygen.tag" "file:///C:/ST_M4_Lib/STM32F30x_StdPeriph_Driver/html"))))
 '(doxymacs-external-xml-parser-executable "c:/Program Files/Tools/doxymacs_parser.bat")
 '(doxymacs-use-external-xml-parser t)
 '(ediff-merge-split-window-function (quote split-window-vertically))
 '(ediff-use-toolbar-p t)
 '(efs-ftp-program-args (quote ("-i" "-n" "-g" "-v" "-p")))
 '(enable-local-variables :all)
 '(erc-autojoin-mode nil)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring smiley stamp track)))
 '(erc-nick "Lupe")
 '(european-calendar-style t)
 '(explicit-shell-file-name "c:\\cygwin64\\bin\\zsh.exe")
 '(ff-ignore-include t)
 '(file-coding-system-alist
   (quote
    (("\\.dz\\'" no-conversion . no-conversion)
     ("\\.g?z\\(~\\|\\.~[0-9]+~\\)?\\'" no-conversion . no-conversion)
     ("\\.\\(?:tgz\\|svgz\\|sifz\\)\\(~\\|\\.~[0-9]+~\\)?\\'" no-conversion . no-conversion)
     ("\\.tbz2?\\'" no-conversion . no-conversion)
     ("\\.bz2\\(~\\|\\.~[0-9]+~\\)?\\'" no-conversion . no-conversion)
     ("\\.Z\\(~\\|\\.~[0-9]+~\\)?\\'" no-conversion . no-conversion)
     ("\\.elc\\'" . utf-8-emacs)
     ("\\.utf\\(-8\\)?\\'" . utf-8)
     ("\\.xml\\'" . xml-find-file-coding-system)
     ("\\(\\`\\|/\\)loaddefs.el\\'" raw-text . raw-text-unix)
     ("\\.tar\\'" no-conversion . no-conversion)
     ("\\.po[tx]?\\'\\|\\.po\\." . po-find-file-coding-system)
     ("\\.\\(tex\\|ltx\\|dtx\\|drv\\)\\'" . latexenc-find-file-coding-system)
     ("\\.org\\'" . utf-8)
     ("" undecided))))
 '(filesets-cache-save-often-flag nil)
 '(filesets-data nil)
 '(find-file-compare-truenames t)
 '(flycheck-gcc-include-path (quote ("../../../Application/Source/")))
 '(fume-max-items 50)
 '(global-auto-revert-mode t)
 '(gnus-select-method (quote (nntp "news.arcor.de")))
 '(gnuserv-program (concat exec-directory "/gnuserv") t)
 '(google-this-keybind "g")
 '(google-this-mode t)
 '(gtags-auto-update (quote all))
 '(gutter-buffers-tab-visible-p nil)
 '(home-end-enable nil)
 '(horizontal-scroll-bar-mode nil)
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-enable-tramp-completion nil)
 '(ido-everywhere t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(ido-use-virtual-buffers nil)
 '(imenu-sort-function (quote imenu--sort-by-name))
 '(indent-tabs-mode nil)
 '(ispell-dictionary-alist
   (quote
    ((nil "[[:alpha:]]" "[^[:alpha:]]" "'" t
          ("-d" "en" "--encoding=utf-8")
          nil utf-8)
     ("english" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en" "--encoding=utf-8")
      nil utf-8)
     ("english-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("english-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("english-variant_2" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-variant_2" "--encoding=utf-8")
      nil utf-8)
     ("english-variant_1" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-variant_1" "--encoding=utf-8")
      nil utf-8)
     ("english-variant_0" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-variant_0" "--encoding=utf-8")
      nil utf-8)
     ("canadian" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_CA" "--encoding=utf-8")
      nil utf-8)
     ("canadian-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_CA-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("canadian-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_CA-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("british" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB" "--encoding=utf-8")
      nil utf-8)
     ("british-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("british-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("british-ize" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ize" "--encoding=utf-8")
      nil utf-8)
     ("british-ize-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ize-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("british-ize-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ize-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("british-ise" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ise" "--encoding=utf-8")
      nil utf-8)
     ("british-ise-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ise-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("british-ise-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ise-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("american" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_US" "--encoding=utf-8")
      nil utf-8)
     ("american-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_US-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("american-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_US-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("en" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en" "--encoding=utf-8")
      nil utf-8)
     ("en-variant_0" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-variant_0" "--encoding=utf-8")
      nil utf-8)
     ("en-variant_1" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-variant_1" "--encoding=utf-8")
      nil utf-8)
     ("en-variant_2" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-variant_2" "--encoding=utf-8")
      nil utf-8)
     ("en-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("en-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_CA" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_CA" "--encoding=utf-8")
      nil utf-8)
     ("en_CA-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_CA-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_CA-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_CA-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_GB" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-ise" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ise" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-ise-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ise-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-ise-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ise-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-ize" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ize" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-ize-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ize-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-ize-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-ize-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_GB-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_GB-wo_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_US" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_US" "--encoding=utf-8")
      nil utf-8)
     ("en_US-w_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_US-w_accents" "--encoding=utf-8")
      nil utf-8)
     ("en_US-wo_accents" "[[:alpha:]]" "[^[:alpha:]]" "'" t
      ("-d" "en_US-wo_accents" "--encoding=utf-8")
      nil utf-8)
     (nil "[A-Za-z]" "[^A-Za-z]" "[']" nil
          ("-B")
          nil iso-8859-1)
     ("brasileiro" "[A-ZÁÉÍÓÚÀÈÌÒÙÃÕÇÜÂÊÔa-záéíóúàèìòùãõçüâêô]" "[^A-ZÁÉÍÓÚÀÈÌÒÙÃÕÇÜÂÊÔa-záéíóúàèìòùãõçüâêô]" "[']" nil
      ("-d" "brasileiro")
      nil iso-8859-1)
     ("castellano" "[A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[^A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[-]" nil
      ("-B" "-d" "castellano")
      "~tex" iso-8859-1)
     ("castellano8" "[A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[^A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[-]" nil
      ("-B" "-d" "castellano")
      "~latin1" iso-8859-1)
     ("czech" "[A-Za-zÁÉÌÍÓÚÙÝ®©ÈØÏ«ÒáéìíóúùýŸ¹èøï»ò]" "[^A-Za-zÁÉÌÍÓÚÙÝ®©ÈØÏ«ÒáéìíóúùýŸ¹èøï»ò]" "" nil
      ("-B" "-d" "czech")
      nil iso-8859-2)
     ("dansk" "[A-ZÆØÅa-zæøå]" "[^A-ZÆØÅa-zæøå]" "[']" nil
      ("-C")
      nil iso-8859-1)
     ("deutsch" "[a-zA-Z\"]" "[^a-zA-Z\"]" "[']" t
      ("-C")
      "~tex" iso-8859-1)
     ("deutsch8" "[a-zA-ZÄÖÜäößü]" "[^a-zA-ZÄÖÜäößü]" "[']" t
      ("-C" "-d" "de-alt")
      "~latin1" iso-8859-1)
     ("esperanto" "[A-Za-zŠ¬¶ŒÆØÝÞæøýþ]" "[^A-Za-zŠ¬¶ŒÆØÝÞæøýþ]" "[-']" t
      ("-C")
      "~latin3" iso-8859-1)
     ("esperanto-tex" "[A-Za-z^\\]" "[^A-Za-z^\\]" "[-'`\"]" t
      ("-C" "-d" "esperanto")
      "~tex" iso-8859-1)
     ("francais7" "[A-Za-z]" "[^A-Za-z]" "[`'^---]" t nil nil iso-8859-1)
     ("francais" "[A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü]" "[^A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü]" "[-']" t nil "~list" iso-8859-1)
     ("francais-tex" "[A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü\\]" "[^A-Za-zÀÂÆÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü\\]" "[-'^`\"]" t nil "~tex" iso-8859-1)
     ("german" "[a-zA-Z\"]" "[^a-zA-Z\"]" "[']" t
      ("-C")
      "~tex" iso-8859-1)
     ("german8" "[a-zA-ZÄÖÜäößü]" "[^a-zA-ZÄÖÜäößü]" "[']" t
      ("-C" "-d" "german")
      "~latin1" iso-8859-1)
     ("italiano" "[A-ZÀÁÈÉÌÍÒÓÙÚa-zàáèéìíóùú]" "[^A-ZÀÁÈÉÌÍÒÓÙÚa-zàáèéìíóùú]" "[-]" nil
      ("-B" "-d" "italian")
      "~tex" iso-8859-1)
     ("nederlands" "[A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[^A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[']" t
      ("-C")
      nil iso-8859-1)
     ("nederlands8" "[A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[^A-Za-zÀ-ÅÇÈ-ÏÒ-ÖÙ-Üà-åçè-ïñò-öù-ü]" "[']" t
      ("-C")
      nil iso-8859-1)
     ("norsk" "[A-Za-zÅÆÇÈÉÒÔØåæçèéòôø]" "[^A-Za-zÅÆÇÈÉÒÔØåæçèéòôø]" "[\"]" nil
      ("-d" "norsk")
      "~list" iso-8859-1)
     ("norsk7-tex" "[A-Za-z{}\\'^`]" "[^A-Za-z{}\\'^`]" "[\"]" nil
      ("-d" "norsk")
      "~plaintex" iso-8859-1)
     ("polish" "[A-Za-z¡£Š¬¯±³¶Œ¿ÆÊÑÓæêñó]" "[^A-Za-z¡£Š¬¯±³¶Œ¿ÆÊÑÓæêñó]" "" nil
      ("-d" "polish")
      nil iso-8859-2)
     ("russian" "[áâ÷çäå³öúéêëìíîïðòóôõæèãþûýøùÿüàñÁÂ×ÇÄÅ£ÖÚÉÊËÌÍÎÏÐÒÓÔÕÆÈÃÞÛÝØÙßÜÀÑ]" "[^áâ÷çäå³öúéêëìíîïðòóôõæèãþûýøùÿüàñÁÂ×ÇÄÅ£ÖÚÉÊËÌÍÎÏÐÒÓÔÕÆÈÃÞÛÝØÙßÜÀÑ]" "" nil
      ("-d" "russian")
      nil koi8-r)
     ("svenska" "[A-Za-zåäöéàüèæøçÅÄÖÉÀÜÈÆØÇ]" "[^A-Za-zåäöéàüèæøçÅÄÖÉÀÜÈÆØÇ]" "[']" nil
      ("-C")
      "~list" iso-8859-1)
     ("portugues" "[a-zA-ZÁÂÉÓàáâéêíóãú]" "[^a-zA-ZÁÂÉÓàáâéêíóãú]" "[']" t
      ("-C" "-d" "portugues")
      "~latin1" iso-8859-1)
     ("slovak" "[A-Za-zÁÄÉÍÓÚÔÀÅ¥Ý®©ÈÏ«ÒáäéíóúôàåµýŸ¹èï»ò]" "[^A-Za-zÁÄÉÍÓÚÔÀÅ¥Ý®©ÈÏ«ÒáäéíóúôàåµýŸ¹èï»ò]" "" nil
      ("-B" "-d" "slovak")
      nil iso-8859-2))) t)
 '(ispell-local-dictionary "british")
 '(ispell-program-name "c:\\Program Files\\Tools\\ispell.bat")
 '(kill-whole-line t)
 '(lazy-lock-stealth-time 60)
 '(line-number-mode t)
 '(lunar-phase-names
   (quote
    ("Neumond" "Erstes Viertel" "Vollmond" "Letztes Viertel")))
 '(make-tags-files-invisible t)
 '(mark-diary-entries-in-calendar t)
 '(mark-holidays-in-calendar t)
 '(mode-compile-always-save-buffer-p t)
 '(mode-compile-never-edit-command-p t)
 '(modifier-keys-are-sticky nil)
 '(modifier-keys-sticky-time 750 t)
 '(mouse-avoidance-mode (quote animate) nil (avoid))
 '(mouse-wheel-mode t nil (mwheel))
 '(mouse-yank-at-point t)
 '(newsticker-html-renderer (quote w3m-region))
 '(newsticker-url-list
   (quote
    (("XBOX 360" "http://www.dreisechzig.net/wp/feed/" nil nil nil))))
 '(newsticker-url-list-defaults
   (quote
    (("Emacs Wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?action=rss" nil 3600)
     ("LWN (Linux Weekly News)" "http://lwn.net/headlines/rss")
     ("slashdot" "http://slashdot.org/index.rss" nil 3600)
     ("Heise News (german)" "http://www.heise.de/newsticker/heise.rdf")
     ("Tagesschau (german)" "http://www.tagesschau.de/newsticker.rdf" nil 1800))))
 '(next-error-highlight (quote fringe-arrow))
 '(omnisharp-imenu-support t)
 '(org-agenda-custom-commands
   (quote
    (("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)
     ("r" "Closed more than one week ago" tags "CLOSED<=\"<-7d>\"" nil))))
 '(org-agenda-files
   (quote
    ("~/org/someday.org" "~/org/newgtd.org" "~/org/journal.org")))
 '(org-agenda-include-diary t)
 '(org-capture-templates
   (quote
    (("t" "Todo" entry
      (file+headline "~/org/newgtd.org" "Aufgaben")
      "* TODO %?
  %i
  %a" :empty-lines-after 1)
     ("j" "Journal" entry
      (file+datetree "~/org/journal.org")
      "* %?
  Erstellt: %U
  %i
  %a" :empty-lines-after 1)
     ("n" "Note" entry
      (file+headline "~/org/journal.org" "Notes")
      "* %?
  Erstellt: %U
  %i
  %a"))))
 '(org-clock-persist t)
 '(org-completion-use-ido t)
 '(org-default-notes-file "~/org/notes.org")
 '(org-ellipsis "…")
 '(org-enforce-todo-dependencies t)
 '(org-export-latex-classes
   (quote
    (("scrartcl" "\\documentclass{scrartcl}
\\KOMAoptions{fontsize=11pt}
\\KOMAoptions{pagesize=pdftex}
\\KOMAoptions{paper=a4}
\\usepackage[T1]{fontenc}
\\usepackage{ae}
\\usepackage{latexsym}
\\usepackage[german]{babel}
\\usepackage[utf8]{inputenc}
\\usepackage[
            plainpages=false,
            colorlinks=true, %Links mit farbigem Text
            linkcolor=blue,
            hyperindex=true,
            bookmarks=true,  %Bookmarks für einzelne Abschnitte
           ]{hyperref}
"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("article" "\\documentclass[11pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{hyperref}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{hyperref}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{hyperref}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))))
 '(org-export-latex-default-class "scrartcl")
 '(org-hide-leading-stars t)
 '(org-refile-targets
   (quote
    (("~/org/newgtd.org" :tag . "PROJECT")
     ("~/org/newgtd.org" :level . 1)
     ("~/org/journal.org" :tag . "NOTES"))))
 '(org-remember-templates
   (quote
    (("private" 112 "* TODO %?
  %i
  %a" "~/org/private.org" "Unsortiert" nil)
     ("work" 119 "* TODO %?
  %i
  %a" "~/org/work.org" "Unsortiert" nil))))
 '(org-return-follows-link t)
 '(org-tab-follows-link t)
 '(package-selected-packages
   (quote
    (german-holidays transpose-frame multiple-cursors cov moccur-edit git-timemachine ox-gfm sx ietf-docs yasnippet wgrep sr-speedbar smart-tabs-mode psvn powershell org-journal omnisharp magit gtags google-this google-maps dictcc cygwin-mount)))
 '(paren-mode (quote blink-paren) nil (paren))
 '(preview-default-document-pt 12)
 '(printer-name nil)
 '(ps-paper-type (quote a4))
 '(ps-print-color-p nil)
 '(ps-printer-name nil)
 '(reb-re-syntax (quote string))
 '(recent-files-commands-submenu t)
 '(recent-files-dont-include
   (quote
    ("~$" "Guinan/." "INBOX" ".bbdb" ".newsrc." "places.el" "^moc_.*" "\\.cache" "TAGS")))
 '(recent-files-non-permanent-submenu nil)
 '(recent-files-number-of-entries 10)
 '(recent-files-number-of-saved-entries 10)
 '(recent-files-permanent-submenu t)
 '(recent-files-sort-function (quote recent-files-sort-alphabetically))
 '(recent-files-use-full-names t)
 '(recentf-mode t nil (recentf))
 '(require-final-newline (quote ask))
 '(safe-local-variable-values
   (quote
    ((vvb-column . 80)
     (time-stamp-format . %:y-%02m-%02d)
     (time-stamp-active . t)
     (gud-gdb-command-name . "arm-none-linux-gnueabi-gdb -quiet --annotate=3 /home/gru/projects/damian-git-svn/DMN/MPC/firmware/bin/milestone_arm_debug")
     (gud-gdb-command-name . "arm-none-linux-gnueabi-gdb --annotate=3 /home/gru/projects/damian-git-svn/DMN/MPC/firmware/bin/milestone_arm_debug")
     (gud-gdb-command-name . "arm-none-linux-gnueabi-gdb --annotate=3 ")
     (compile-command . "make -k -j ")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\Trade\\TRADE_SW\\Application\\Compile\\DemoBlink.ewp\" -make Debug -log info")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\Trade\\Applications\\TestLibraryD_E\\Projects\\IAR_ARM\\TestLibraryD_E\\TestLibraryD_E.ewp\" -make Debug -log info")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\ESMS\\Application\\Compile\\ESMS_Oel.ewp\" -make Debug -log info")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\ESMD\\Application\\Compile\\ESMD_Oel.ewp\" -make Debug -log info")
     (compile-command . "c:\\Program Files (x86)\\MSBuild\\12.0\\Bin\\MSBuild.exe")
     (compile-command . "make -C .. -j gcov")
     (compile-command . "make -C .. -j")
     (compile-command . "iarbuild \"c:\\SiliconLabs\\EmberZNet5.7.0-GA\\app\\builder\\EM358_HostApp_ST\\EM358_HostApp_ST_M4_UART.ewp\" -make Debug -log info")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\ESMX\\Application\\Compile\\ESMx.ewp\" -make Debug -log info")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\ESMX_zigbee\\Application\\Compile\\ESMx.ewp\" -make Debug -log info")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\v2_2_x\\Application\\Compile\\ESMx.ewp\" -make Debug -log info")
     (compile-command . "iarbuild \"c:\\Users\\m.grunwald\\Documents\\Projects\\LUXeye\\ESMX_ZigBee\\Application\\Compile\\ESMx.ewp\" -make Debug -log info"))))
 '(save-place t nil (saveplace))
 '(scroll-margin 0)
 '(semantic-idle-scheduler-idle-time 2)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(server-switch-hook nil)
 '(show-paren-mode t nil (paren))
 '(sieve-manage-default-port 4190)
 '(signal-error-on-buffer-boundary nil)
 '(speedbar-directory-button-trim-method (quote trim))
 '(speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.svn\\)\\'")
 '(speedbar-frame-parameters
   (quote
    ((minibuffer)
     (width . 36)
     (border-width . 0)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t))))
 '(speedbar-frame-plist
   (quote
    (minibuffer nil width 37 border-width 0 internal-border-width 0 unsplittable t default-toolbar-visible-p nil has-modeline-p nil menubar-visible-p nil default-gutter-visible-p nil)))
 '(speedbar-show-unknown-files t)
 '(speedbar-supported-extension-expressions
   (quote
    (".bnf" ".pro" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java" ".f\\(90\\|77\\|or\\)?" ".ada" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py" ".s?html" "[Mm]akefile\\(\\.in\\)?")))
 '(svn-status-default-diff-arguments nil)
 '(svn-status-hide-externals t)
 '(svn-status-hide-unknown t)
 '(svn-status-hide-unmodified t)
 '(tab-always-indent (quote complete))
 '(tab-width 4)
 '(tags-always-exact t)
 '(tags-auto-read-changed-tag-files t)
 '(tags-check-parent-directories-for-tag-files nil)
 '(tags-exuberant-ctags-optimization-p t)
 '(tex-close-quote "\"'")
 '(tex-open-quote "\"`")
 '(time-stamp-active nil)
 '(time-stamp-format "%:y-%02m-%02dT%02H:%02M:%02S+%Z %U")
 '(toolbar-visible-p nil)
 '(tooltip-gud-tips-p t)
 '(track-eol t)
 '(tramp-default-method-alist
   (quote
    (("" "%" "smb")
     ("" "\\`\\(anonymous\\|ftp\\)\\'" "ftp")
     ("\\`ftp\\." "" "ftp")
     ("\\`localhost\\'" "\\`root\\'" "su")
     ("\\`10.1.2" "" "ftp"))))
 '(transient-mark-mode t)
 '(truncate-lines t)
 '(undo-high-threshold 300000)
 '(undo-threshold 200000)
 '(url-be-asynchronous t)
 '(url-news-server nil)
 '(url-personal-mail-address nil)
 '(url-privacy-level (quote paranoid))
 '(url-proxy-services nil)
 '(url-show-status nil)
 '(url-use-hypertext-gopher nil)
 '(user-full-name "Markus Grunwald")
 '(user-mail-address "m.grunwald@osram.com")
 '(vc-mode-face (quote highlight))
 '(visible-bell t)
 '(vvb-column 80 t)
 '(vvb-mode t t)
 '(vvb-right-on-eol-p nil t)
 '(w3-delay-image-loads t)
 '(w3-do-incremental-display t)
 '(w3-icon-format nil)
 '(w3-maximum-line-length 100)
 '(w3-min-img-size 5)
 '(w3m-use-cookies t)
 '(whitespace-auto-cleanup t)
 '(whitespace-check-spacetab-whitespace nil)
 '(woman-cache-filename "~/.emacs.d/woman-cache.el")
 '(woman-imenu t)
 '(woman-manpath (quote ("c:/cygwin64/usr/share/man")))
 '(woman-use-own-frame nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 102 :width normal :foundry "normal" :family "DejaVu Sans Mono"))))
 '(grep-edit-face ((((class color) (background light)) (:background "LightGreen" :weight bold))))
 '(hi-yellow ((t (:foreground "#f0dfaf" :inverse-video t))))
 '(highlight ((((class color) (background light)) (:background "gray80"))))
 '(hl-line ((t nil)))
 '(menu ((t (:background "#1e2320" :foreground "goldenrod"))))
 '(org-hide ((((background light)) (:foreground "gray90"))))
 '(show-paren-match ((t (:inverse-video t))))
 '(sml-modeline-end-face ((t (:background "#3f3f3f"))))
 '(vvb-face ((t (:background "#2A2A2A"))) t)
 '(w3m-form ((((class color) (background light)) (:foreground "red" :underline t))))
 '(whitespace-hspace ((t (:foreground "gray40"))))
 '(whitespace-indentation ((t (:foreground "firebrick"))))
 '(whitespace-newline ((t (:foreground "gray40" :weight normal))))
 '(whitespace-space ((t (:foreground "gray40"))))
 '(whitespace-space-after-tab ((t (:foreground "firebrick"))))
 '(whitespace-tab ((t (:foreground "gray40")))))
