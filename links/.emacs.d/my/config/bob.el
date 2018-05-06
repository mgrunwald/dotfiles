;;
;; Per host configuration file.
;; Only settings that can not be shared between all hosts belong here.
;;
(message "loading bob.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote
                                browse-url-chromium))
 )

(message "finished bob.el")
