;;
;; Per host configuration file.
;; Only settings that can not be shared between all hosts belong here.
;;
(message "loading pc-cm-gru-virtlinux1.el")
(set-variable 'Info-additional-directory-list (quote
                                               ("/opt/emacs23/share/info/"
                                                "/home/gru/info"
                                                "/usr/local/share/info")))
(set-variable 'calendar-latitude [48 8 north])
(set-variable 'calendar-location-name "Ismaning")
(set-variable 'calendar-longitude [11 43 east])
(set-variable 'compile-command "make -k -j9")
(set-variable 'copyright-regexp "\\([[:space:]]*[\\*#][[:space:]]*([cC])[[:space:]]+[[:digit:]]\\{4\\}\\) - \\([[:digit:]]\\{4\\}\\) by .*[pP]ruftechnik.*$")
(set-variable 'doxymacs-external-xml-parser-executable "/usr/lib/doxymacs/doxymacs_parser")
(set-variable 'doxymacs-use-external-xml-parser t)
(set-variable 'recent-files-filename-replacements (quote
                                                   (("/home/gru/projects/vxp/trunk"
                                                     . "trunk")
                                                    ("/mnt/ext1/home/gru"
                                                     . "~")
                                                    ("/home/gru"
                                                     . "~")
                                                    ("/home/gru/projects/vxp/branches"
                                                     . "branches"))))

(set-variable 'w3-default-homepage "file:///home/gru/doc/dafit/1.50/html/index.html")


(load "emacs-rc-cedet.el")

;; autoinsert.el
;; automatic insertion of text into new files.
;; Find appropriate skeletons for various modes.
;; this just shows the syntax
(load "pt-auto-insert" nil nil nil)

(message "finished pc-cm-gru-virtlinux1.el")



