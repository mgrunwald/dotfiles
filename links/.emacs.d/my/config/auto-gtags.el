;;; auto-gtags.el --- Automatically update gtags when saving a file  -*- lexical-binding: t; -*-

;; Copyright (C) 2015

;; Author:  <M.Grunwald@MCH-H5HNY52>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; http://www.emacswiki.org/emacs/GnuGlobal

;;; Code:

(defcustom gtags-auto-update 'nil
  "Way of updating the gnu global tags
The tags for gnu global (gtags) can be updated everytime a file is
  saved.
This customisation defines whether all gtags are updated (global -u),
which is ok for small projects or whether only the gtags for the saved
file are updated."
  :group 'gtags
  :type '(choice (const :tag "Update all" all)
                (const :tag "Update file" file)
                (const :tag "No auto update" nil))
)


(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil 0 nil "-u"))

(defun gtags-update-single(filename)
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process "update-gtags" "update-gtags" "bash" "-c"
                 (concat
                  "cd "
                  (gtags-root-dir)
                  " ; gtags --single-update " filename )))

(defun gtags-update-current-file()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))

(defun gtags-update-hook()
  "Update GTAGS file incrementally upon saving a file"
  (when gtags-mode
    (when (gtags-root-dir)
      (cond ((eq gtags-auto-update 'all ) (gtags-update))
            ((eq gtags-auto-update 'file) (gtags-update-current-file))
            )
      )))

(if gtags-auto-update
    (add-hook 'after-save-hook 'gtags-update-hook))

(provide 'auto-gtags)
;;; auto-gtags.el ends here
