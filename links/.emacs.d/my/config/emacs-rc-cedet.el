;;; emacs-rc-cedet.el ---

;; Copyright (C) 2003 Alex Ott
;;
;; Author: alexott@gmail.com
;;
;; Geklaut und für mich angepasst von markus grunwald
;;
(message "loading emacs-rc-cedet.el")


;; (semantic-load-enable-minimum-features) ;; enables only minimum of necessary features
;; (semantic-load-enable-code-helpers) ;;enables senator-minor-mode for navigation in buffer, semantic-mru-bookmark-mode for storing positions of visited tags, and semantic-idle-summary-mode, that shows information about tag under point;
;; (semantic-load-enable-gaudy-code-helpers) ;;enables semantic-stickyfunc-name that displays name of current function in topmost line of buffer, semantic-decoration-mode to decorate tags, using different faces, and semantic-idle-completion-mode for automatic generation of possible names completions, if user stops his work for some time;
;; (semantic-load-enable-excessive-code-helpers) ;;enables which-func-mode, that shows name of current function in status line;
;; (semantic-load-enable-semantic-debugging-helpers) ;;enables several modes, that are useful when you debugging Semantic — displaying of parsing errors, its state, etc.

;; (setq senator-minor-mode-name "SN")
;; (setq semantic-imenu-auto-rebuild-directory-indexes nil)
;; (global-srecode-minor-mode 1)
;; (global-semantic-mru-bookmark-mode 1)

;; (require 'semantic-decorate-include)

;; ;; gcc setup
;; (require 'semantic-gcc)

;; ;; smart complitions
;; (require 'semantic-ia)

;; (setq-mode-local c-mode semanticdb-find-default-throttle
;;                  '(project unloaded system recursive))
;; (setq-mode-local c++-mode semanticdb-find-default-throttle
;;                  '(project unloaded system recursive))
;; (setq-mode-local erlang-mode semanticdb-find-default-throttle
;;                  '(project unloaded system recursive))

;;(require 'eassist)

;; ;; customisation of modes
;; (defun mg/cedet-hook ()
;;   ;; (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
;;   ;; (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
;;   ;; ;;
;;   ;; (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   ;; (local-set-key "\C-c=" 'semantic-decoration-include-visit)

;;   ;; (local-set-key "\C-cj" 'semantic-ia-fast-jump)
;;   ;; (local-set-key "\C-cq" 'semantic-ia-show-doc)
;;   ;; (local-set-key "\C-cs" 'semantic-ia-show-summary)
;;   ;; (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;   (semantic-stickyfunc-mode)
;;   )

;; ;; (add-hook 'semantic-init-hooks 'mg/cedet-hook)
;; (add-hook 'c-mode-common-hook 'mg/cedet-hook)
;; (add-hook 'lisp-mode-hook 'mg/cedet-hook)
;; (add-hook 'scheme-mode-hook 'mg/cedet-hook)
;; (add-hook 'emacs-lisp-mode-hook 'mg/cedet-hook)
;; (add-hook 'erlang-mode-hook 'mg/cedet-hook)


(setq eassist-header-switches
      '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
        ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
        ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
        ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
        ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
        ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
        ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
        ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
        ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
        ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
        ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
        ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("c" . ("h"))
        ("m" . ("h"))
        ("mm" . ("h"))))

;; (defun mg/c-mode-cedet-hook ()
;;   ;; (local-set-key "." 'semantic-complete-self-insert)
;;   ;; (local-set-key ">" 'semantic-complete-self-insert)
;;   ;; (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;;   ;; (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-ce" 'eassist-list-methods)
;;   ;; (local-set-key "\C-c\C-r" 'semantic-symref)
;;   )
;; (add-hook 'c-mode-common-hook 'mg/c-mode-cedet-hook)

;; ;; hooks, specific for semantic
;; (defun mg/semantic-hook ()
;; ;; (semantic-tag-folding-mode 1)
;;   (imenu-add-to-menubar "TAGS")
;;  )
;; (add-hook 'semantic-init-hooks 'mg/semantic-hook)

;; (custom-set-variables
;;  '(semantic-idle-scheduler-idle-time 2)
;;  '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
;;  '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))
;; (global-semantic-folding-mode 1)

;; ;; gnu global support
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;; ;; ctags
;; (require 'semanticdb-ectag)
;; (semantic-load-enable-primary-exuberent-ctags-support)

;; ;;
;; (semantic-add-system-include "/usr/local/include" 'c++-mode)
;; (semantic-add-system-include "/opt/qt/x86/qt3/include" 'c++-mode)
;; (semantic-add-system-include "/usr/local/include/pt" 'c++-mode)

;; ;; DSP/BIOS
;; ( let* (( dsp-base-toolchain "/home/gru/OMAPL137_arm_1_00_00_11")
;;         ( dsp-base-sabios   (concat dsp-base-toolchain "/bios_5_33_05" ) )
;;         ( dsp-base-compiler (concat dsp-base-toolchain "/cg6x_6_1_9" ) )
;;         ( dsp-dsplink (concat dsp-base-toolchain "/dsplink-1_61_03-prebuilt/packages/dsplink") ))
;;   (semantic-add-system-include (concat dsp-dsplink "/dsp/inc" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-dsplink "/dsp/inc/DspBios" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-dsplink "/dsp/inc/DspBios/5.XX" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-dsplink "/dsp/inc/DspBios/5.XX/OMAPL1XXGEM" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-dsplink "/dsp/inc/C64XX" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-base-sabios "/packages/ti/bios/include" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-base-compiler "/include" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-base-sabios "/packages/ti/rtdx/include/c6000" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-base-sabios "/packages/ti/psl/include" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-dsplink "/dsp/export/INCLUDE/DspBios/OMAPL1XX" ) 'c-mode)
;;   (semantic-add-system-include (concat dsp-base-toolchain "/linuxutils_2_23_01/packages/ti/sdo/linuxutils/cmem/include" ) 'c-mode)
;;   )

;; ( let (( damian-firmware-base
;;          "/home/gru/projects/damian/trunk/MPC/firmware" ))
;;   ( semantic-add-system-include (concat damian-firmware-base "/dao" ) 'c++-mode )
;;   ( semantic-add-system-include (concat damian-firmware-base "/setup" ) 'c++-mode )
;;   ( semantic-add-system-include (concat damian-firmware-base "/measurement" ) 'c++-mode )
;;   ( semantic-add-system-include (concat damian-firmware-base "/measurement/confighandling" ) 'c++-mode )
;;   ( semantic-add-system-include (concat damian-firmware-base "/measurement/devicecom/" ) 'c++-mode )
;;   ( semantic-add-system-include (concat damian-firmware-base "/measurement/resulthandling/" ) 'c++-mode )
;; )

;; (add-to-list 'auto-mode-alist '("/opt/qt/x86/qt3/include" . c++-mode))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file "/opt/qt/x86/qt3/include/qconfig.h")

;; ;;
;; (global-semantic-idle-tag-highlight-mode 1)

;;; ede customization
;;(require 'semantic-lex-spp)
(global-ede-mode t)

;; cpp-tests project definition
;; (setq cpp-tests-project
;;       (ede-cpp-root-project "cpp-tests"
;;                             :file "~/projects/lang-exp/cpp/CMakeLists.txt"
;;                             :system-include-path '("/home/ott/exp/include"
;;                                                    boost-base-directory)
;;                             :local-variables (list
;;                                               (cons 'compile-command 'mg/gen-cmake-debug-compile-string)
;;                                               )
;;                             ))

;; (setq squid-gsb-project
;;       (ede-cpp-root-project "squid-gsb"
;;                             :file "~/projects/squid-gsb/README"
;;                             :system-include-path '("/home/ott/exp/include"
;;                                                    boost-base-directory)
;;                             :local-variables (list
;;                                               (cons 'compile-command 'mg/gen-cmake-debug-compile-string)
;;                                               )
;;                             ))
;; (setq arabica-project
;;       (ede-cpp-root-project "arabica"
;;                             :file "~/projects/arabica-devel/README"
;;                             :system-include-path '("/home/ott/exp/include"
;;                                                    boost-base-directory)
;;                             :local-variables (list
;;                                               (cons 'compile-command 'mg/gen-std-compile-string)
;;                                               )
;;                             ))

(setq damian-firmware-project
      (ede-cpp-root-project "damian-firmware-project"
                            :file "~/projects/damian/trunk/MPC/firmware/src/damian.pro"
                            :local-variables (list
                                              (cons 'compile-command
                                                    'mg/gen-damian-fw-compile-string
                                                    )
                                              (cons 'indent-tabs-mode t )
                                              (cons  'mg-auto-insert-style 'damian )
                                              )
                            )
      )

(setq damian-gitsvn-firmware-project
      (ede-cpp-root-project "damian-gitsvn-firmware-project"
                            :file "~/projects/damian-git-svn/DMN/MPC/firmware/src/damian.pro"
                            :local-variables (list
                                              (cons 'compile-command
                                                     'mg/gen-damian-fw-compile-string
                                                    )
                                              (cons 'indent-tabs-mode t )
                                              (cons  'mg-auto-insert-style 'damian )
                                              )
                            )
      )


;; (setq damian-test-project
;;       (ede-cpp-root-project "damian-test-project"
;;                             :file "~/projects/damian/trunk/MPC/firmware/TESTING/AutomaticTests/AutomaticTests.pro"
;;                             :local-variables (list
;;                                               (cons 'compile-command
;;                                                     'mg/gen-plain-make-compile-string
;;                                                     )
;;                                               (cons 'indent-tabs-mode t )
;;                                               )
;;                             )
;;       )


;; my functions for EDE
(defun mg/ede-get-local-var (fname var)
  "fetch given variable var from :local-variables of project of file fname"
  (let* ((current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (when prj
      (let* ((ov (oref prj local-variables))
            (lst (assoc var ov)))
        (when lst
          (cdr lst))))))

;; setup compile package
;; TODO: allow to specify function as compile-command
;; (require 'compile)
;; (setq compilation-disable-input nil)
;; (setq compilation-scroll-output t)
;; (setq mode-compile-always-save-buffer-p t)

(defun mg/compile (arg)
  "Saves all unsaved buffers, and runs 'compile'."
  (interactive "P" )
  (save-some-buffers t)
  (let* ((r (mg/ede-get-local-var
             (or (buffer-file-name (current-buffer)) default-directory)
             'compile-command))
         (cmd (if (functionp r) (funcall r) r)))
;;    (message "AA: %s" cmd)
    (set (make-local-variable 'compile-command) (or cmd compile-command))
    (when arg (setq compile-command (read-from-minibuffer "Compile command: "
					   compile-command nil nil
					   '(compile-history . 1)))
          )
    (compile compile-command)))

(global-set-key [f9] 'mg/compile)

;;
(defun mg/gen-std-compile-string ()
  "Generates compile string for compiling a project in debug mode"
  (let* ((current-dir (file-name-directory
                       (or (buffer-file-name (current-buffer)) default-directory)))
         (prj (ede-current-project current-dir))
         (root-dir (ede-project-root-directory prj))
         )
    (concat "cd " root-dir "; make DEBUG=1")
    )
  )

;;
(defun mg/gen-damian-fw-compile-string ()
  "Generates compile string for compiling a project in debug mode"
  (let* ((current-dir (file-name-directory
                       (or (buffer-file-name (current-buffer)) default-directory)))
         (prj (ede-current-project current-dir))
         (root-dir (ede-project-root-directory prj))
         )
    (concat "cd " root-dir "; make -k -j 6 sub-firmware")
    )
  )

(defun mg/gen-xdc-compile-string ()
  "Generates compile string for compiling a project with xdc."
  (let* ((current-dir (file-name-directory
                       (or (buffer-file-name (current-buffer)) default-directory)))
         (prj (ede-current-project current-dir))
         (root-dir (ede-project-root-directory prj))
         )
    (concat "cd " root-dir "; xdc -ra")
    )
  )

(defun mg/gen-plain-make-compile-string ()
  "Generates compile string for compiling a project in debug mode"
    (concat "make"))

;;(mg/gen-std-compile-string)

;; ;;
;; (defun mg/gen-cmake-debug-compile-string ()
;;   "Generates compile string for compiling CMake project in debug mode"
;;   (let* ((current-dir (file-name-directory
;;                        (or (buffer-file-name (current-buffer)) default-directory)))
;;          (prj (ede-current-project current-dir))
;;          (root-dir (ede-project-root-directory prj))
;;          (subdir "")
;;          )
;;     (when (string-match root-dir current-dir)
;;       (setf subdir (substring current-dir (match-end 0))))
;;     (concat "cd " root-dir "Debug/" "; make -j2")))
;; ;;    (concat "cd " root-dir "Debug/" subdir "; make -j3")))

;; Example, Qt customization
;; (setq qt4-base-dir "/usr/include/qt4")
;; (setq qt4-gui-dir (concat qt4-base-dir "/QtGui"))
;; (setq qt4-core-dir (concat qt4-base-dir "/QtCore"))
;; (semantic-add-system-include qt4-base-dir 'c++-mode)
;; (semantic-add-system-include qt4-gui-dir 'c++-mode)
;; (semantic-add-system-include qt4-core-dir 'c++-mode)

;; (add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-large.h"))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))

;;; emacs-rc-cedet.el ends here

(message "finished emacs-rc-cedet.el")
