;;; oel.el --- Major Mode for the Osram Event Language  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Markus Grunwald

;; Author: Markus Grunwald <m.grunwald@osram.com>
;; Keywords: lisp, convenience, languages

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

;; This file implements an emacs mode for the OSRAM Event Language (oel)

;;; Code:

(defcustom oel-mode-compiler-path ""
  "Path to the oel compiler. See `oel-mode-compiler-executable`"
  :group 'oel-mode
  :type '(string)
  :risky t
  )

(defcustom oel-mode-compiler-executable "ESMxOelTool.exe"
  "The oel compiler executable. See `oel-mode-compiler-path`"
  :group 'oel-mode
  :type '(string)
  :risky t
  )

(defvar oel-mode-hook nil)

(defvar oel-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [(return)] 'newline-and-indent)
    (define-key map [(meta-y)] 'imenu )
    (define-key map [(control-c) (control-c)] 'compile )
    map)
  "Keymap for `oel-mode'.")

(defvar oel-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_  "w" st)
    (modify-syntax-entry ?#  "<" st)
    (modify-syntax-entry ?\n ">" st)
    (modify-syntax-entry ?/  ". 12" st)
    ;; (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax table for `oel-mode'.")

;; (regexp-opt '( "If" "Else" "EndIf" "EventList") t)
;; (regexp-opt '( "$global_\sw+" "$local_\sw+" "$persistent_\sw+") t)
;; (regexp-opt '( "BitsSet" "BitsClear" "Exit" "Jump"
;;                "SetVariableAddress" "ReStart" "Start" "Stop" "Break"
;;                "GoOn" "SetPriorityLow" "SetPriorityHigh" "Delay"
;;                "DaliTo255Procent" "Procent255ToDali"
;;                "DaliTo100Procent" "Procent100ToDali"
;;                "EventConnectEventList" "ReadSignalEvent"
;;                "LedOff" "LedOn" "LedToggle"
;;                "RelayOn" "RelayOff" "RelayToggle"
;;                "Send2Byte" "SendCoupler" "Send3Byte" "SendOsram"
;;                "Query" "PrepareSequence" "ReadSignalEvent"
;;                "AutoCouplerConfig" "SendCouplerConfigurationValue"
;;                "CalculatePhysMinLevel" "ESMxCopySensorValue"
;;                "ESMxGetParameter" "ESMxSetParameter"
;;                "ESMxDefaultConfigAndRestart"
;;                "ESMxDeleteConfigName" "ESMxDelayT1" "ESMxDelayT2"
;;                "ESMxDelayT3"
;;                "ESMxGetRegulationValue"
;;                "ESMxRegulationLevelChangedByApp"
;;                "ESMxReportError"
;;                "ESMxUpdateLiveData"
;;                "ESMxCheckPowerFailure" "ESMxControlRedLedBlinking"
;;                "LightListUpdateBallastSimple" "LightListUpdateRelay"
;;                "LightListUpdateBallastTwSimple"
;;                "LightControlListLightOn" "LightControlListLightOff"
;;                "LightControlListLightRestore"
;;                "LightControlListRepairLastLevel"
;;                "LightControlListLevel" "LightControlListLevelProcent"
;;                "LightControlListSetLevelSimple"
;;                "LightControlListGetActualLevel"
;;                "LightControlListSetMired"
;;                "LightControlListSetLevelMired"
;;                "LightControlListBLButtonLight"
;;                "LightControlListBLMonitorLight"
;;                "LightControlListButtonShortLevel"
;;                "LightControlListButtonLongLevel"
;;                "LightControlListButtonLongMired"
;;                "LightControlListPirOn" "LightControlListPirOff"
;;                "LightControlListPirActivate"
;;                "LightControlListPirLightOn"
;;                "LightControlListPirLightStep"
;;                "LightControlListPirLightStep"
;;                "LightControlListPirLightOff"
;;                "LightControlListPirTestStandby"
;;                "LightControlListRegulationStartCalibration"
;;                "LightControlListRegulationStopCalibration"
;;                "LightControlListRegulationCalculateSetPoint"
;;                "LightControlListRegulation"
;;                "LightControlListRegulationGetState"
;;                "LightControlListRegulationChangeScale"
;;                "LightControlListRegulationUpdateLevel"
;;                "LightControlListTwilightStartCalibration"
;;                "LightControlListTwilightCalibration"
;;                "LightControlListTwilight"
;;                "LightControlListTwilightGetState"
;;                "SetEventListId"
;;                "Trace" "DelayFadeTime" "LightSensorsQueryValues"
;;                "LightControlListPirStop" "LightControlListPirTest"
;;                ) t)

;; (defconst wpdl-font-lock-keywords-1
;;   (list
;;    '("\\<\\(A\\(CTIVITY\\|PPLICATION\\)\\|DATA\\|END_\\(A\\(CTIVITY\\|PPLICATION\\)\\|DATA\\|MODEL\\|PARTICIPANT\\|T\\(OOL_LIST\\|RANSITION\\)\\|WORKFLOW\\)\\|MODEL\\|PARTICIPANT\\|T\\(OOL_LIST\\|RANSITION\\)\\|WORKFLOW\\)\\>" . font-lock-builtin-face)
;;    '("\\('\\w*'\\)" . font-lock-variable-name-face))
;;   "Minimal highlighting expressions for WPDL mode")

(defconst oel-font-lock-keywords
  (list
   '("\\<\\(E\\(?:lse\\|ndIf\\|ventList\\)\\|If\\)\\>" . font-lock-builtin-face)
   '("\\(\\$\\(?:\\(?:global\\|local\\|persistent\\)_\\sw+\\)\\)"
     . font-lock-variable-name-face)
   '("\\<\\(AutoCouplerConfig\\|B\\(?:its\\(?:Clear\\|Set\\)\\|reak\\)\\|CalculatePhysMinLevel\\|D\\(?:aliTo\\(?:\\(?:100\\|255\\)Procent\\)\\|elay\\(?:FadeTime\\)?\\)\\|E\\(?:SMx\\(?:C\\(?:heckPowerFailure\\|o\\(?:ntrolRedLedBlinking\\|pySensorValue\\)\\)\\|De\\(?:faultConfigAndRestart\\|l\\(?:ayT[123]\\|eteConfigName\\)\\)\\|Get\\(?:Parameter\\|RegulationValue\\)\\|Re\\(?:gulationLevelChangedByApp\\|portError\\)\\|SetParameter\\|UpdateLiveData\\)\\|\\(?:ventConnectEventLis\\|xi\\)t\\)\\|GoOn\\|Jump\\|L\\(?:ed\\(?:O\\(?:ff\\|n\\)\\|Toggle\\)\\|ight\\(?:ControlList\\(?:B\\(?:L\\(?:\\(?:Button\\|Monitor\\)Light\\)\\|utton\\(?:Long\\(?:Level\\|Mired\\)\\|ShortLevel\\)\\)\\|GetActualLevel\\|L\\(?:evel\\(?:Procent\\)?\\|ight\\(?:O\\(?:ff\\|n\\)\\|Restore\\)\\)\\|Pir\\(?:Activate\\|Light\\(?:O\\(?:ff\\|n\\)\\|Step\\)\\|O\\(?:ff\\|n\\)\\|Stop\\|Test\\(?:Standby\\)?\\)\\|Re\\(?:gulation\\(?:C\\(?:alculateSetPoint\\|hangeScale\\)\\|GetState\\|St\\(?:\\(?:art\\|op\\)Calibration\\)\\|UpdateLevel\\)?\\|pairLastLevel\\)\\|Set\\(?:Level\\(?:Mired\\|Simple\\)\\|Mired\\)\\|Twilight\\(?:Calibration\\|GetState\\|StartCalibration\\)?\\)\\|ListUpdate\\(?:Ballast\\(?:\\(?:Tw\\)?Simple\\)\\|Relay\\)\\|SensorsQueryValues\\)\\)\\|Pr\\(?:epareSequence\\|ocent\\(?:\\(?:100\\|255\\)ToDali\\)\\)\\|Query\\|Re\\(?:Start\\|adSignalEvent\\|lay\\(?:O\\(?:ff\\|n\\)\\|Toggle\\)\\)\\|S\\(?:e\\(?:nd\\(?:2Byte\\|3Byte\\|Coupler\\(?:ConfigurationValue\\)?\\|Osram\\)\\|t\\(?:EventListId\\|Priority\\(?:High\\|Low\\)\\|VariableAddress\\)\\)\\|t\\(?:art\\|op\\)\\)\\|Trace\\)\\>"
     . font-lock-function-name-face)
   )
  "Keyword highlighting specification for `oel-mode'.")

;; (defvar oel-imenu-generic-expression
;;   ...)

;; (defvar oel-outline-regexp
;;   ...)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.oel\\'" . oel-mode))

 ;;;###autoload
(define-derived-mode oel-mode fundamental-mode "Oel"
  "A major mode for editing Oel files."
  :syntax-table oel-mode-syntax-table
  (setq-local comment-start "// ")
  (setq-local comment-end "")
  (setq-local comment-start-skip "\\s<+\\s-*")
  (setq-local font-lock-defaults
              '(oel-font-lock-keywords nil t)
              )
  (setq-local tab-width 2)
  (setq-local default-tab-width 2)
  (setq-local indent-line-function 'oel-indent-line)
  (setq-local compile-command (oel-compiler-command))
  (setq-local imenu-generic-expression
              '((nil "^\\s *EventList\\s +\\(\\sw+\\)" 1)) )
  ;; (setq-local outline-regexp oel-outline-regexp)
  ;; ...
  )

 ;;; Indentation

(defun oel-indent-line ()
  "Indent current line of Oel code."
  (interactive)
  (beginning-of-line)
  (let ((savep (> (current-column) (current-indentation)))
        (indent (condition-case nil (max (oel-calculate-indentation) 0)
                  (error 0))))
    (if savep
        (save-excursion (indent-line-to indent))
      (indent-line-to indent))))

(defun oel-calculate-indentation ()
  "Return the column to which the current line should be indented."
  (let ((not-indented t) (cur-indent 0) )
    (if (bobp)
        (setq cur-indent 0)		   ; First line is always non-indented
      (if (looking-at "^\\s *End\\(If\\|List\\)") ; If the line we are looking at is the end of a block, then decrease the indentation
          (progn
            (save-excursion
              (forward-line -1)
              (setq cur-indent (- (current-indentation) default-tab-width)))
            (if (< cur-indent 0) ; We can't indent past the left margin
                (setq cur-indent 0)))
        (if (looking-at "^\\s *\\sw+:")  ; labels
            (setq cur-indent 0)
          (save-excursion
            (while not-indented ; Iterate backwards until we find an indentation hint
              (forward-line -1)
              (if (looking-at "^\\s *End\\(If\\|List\\)") ; This hint indicates that we need to indent at the level of the END_ token
                  (progn
                    (setq cur-indent (current-indentation))
                    (setq not-indented nil))
                (if (looking-at "^\\s *\\(If\\|EventList\\|Else\\)") ; This hint indicates that we need to indent an extra level
                    (progn
                      (setq cur-indent (+ (current-indentation) default-tab-width)) ; Do the actual indenting
                      (setq not-indented nil))
                  (if (bobp)
                      (setq not-indented nil))
                  )
                )
              )
            )
          )
        )
      )
    cur-indent
    )
  )

(defun oel-compiler-command ()
    "Returns the absolute, complete path to the oel compiler and the
in- and out-file. See `oel-mode-compiler-path` and `oel-mode-compiler-executable`"
  (if (file-name-absolute-p oel-mode-compiler-executable)
      oel-mode-compiler-executable
    (concat
     (file-name-as-directory oel-mode-compiler-path)
     oel-mode-compiler-executable
     " "
     (file-name-nondirectory (buffer-file-name))
     " "
     (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))
     ".h"
     )
    )
  )



(provide 'oel-mode)
;;; oel.el ends here
