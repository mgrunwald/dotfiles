;;; Code:

;;; Link this file to ~/.emacs


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;(when
;    (load
;         (expand-file-name "~/.emacs.d/elpa/package.el"))
;           (package-initialize))

(require 'package)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)


;; This directory contains all the xemacs relevant stuff:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
;; load per host configuration. Hosts that share this configuration
;; can do this with links.
(load (concat my-emacs-dir "config/" (system-name)  ".el" ) )
;;}}}
;;============================================================================

;;(setq abbrev-file-name             ;; tell emacs where to read abbrev
;;      "~/.emacs.d/my/config/abbrev_defs.el")    ;; definitions from...
;;(read-abbrev-file abbrev-file-name t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;============================================================================                                                                                           ;;{{{ Desktop for saving whole sessions
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; this should be near the end of my .xemacs-options
;; (desktop-load-default)
;; (add-hook 'kill-emacs-hook
;;           '(lambda ()
;;                 (desktop-truncate search-ring 3)
;;                 (desktop-truncate regexp-search-ring 3)
;;                 (desktop-save-in-desktop-dir)
;;                 (desktop-release-lock )
;;                 ))
;; (desktop-read)
;;}}}
;;============================================================================


(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
