;; Enable transient mark mode
(transient-mark-mode 1)

;; Truncate lines
;;(toggle-truncate-lines t)

;; Visual line mode
(visual-line-mode t)

;; splash-screen
(setq inhibit-splash-screen t)

;; MacOS modifiers
(setq default-input-method "MacOSX")
(setq mac-command-modifier 'meta
      mac-option-modifier nil
      mac-allow-anti-aliasing t
      mac-command-key-is-meta t)

;; Packages
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; mouse
(xterm-mouse-mode 1)

;; mail agent
(setq mail-user-agent 'mu4e-user-agent)

;; Coding
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(setq mm-coding-system-priorities '(utf-8-unix))

;; Scrolling one line at a time    
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;-------------------------- Easy PG -----------------------------------
(require 'epa-file)
;;(epa-file-enable)
(setq epa-pinentry-mode 'loopback)


;;---------------------------------ESS-----------------------------------
(add-to-list 'load-path "/Users/alex/local/ess-17.11/lisp/")
(require 'ess-site)
;; julia
(setq  inferior-julia-program-name "/usr/local/bin/julia")
;; ob-julia
(add-to-list 'load-path "/Users/alex/local/emacs-modes/ob-julia/")

;;------------------------exec-path-from-shell---------------------------
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;------------------------------Org-mode---------------------------------
(add-to-list 'load-path "~/local/emacs-modes/org-mode/lisp")
(require 'org)

;;pdf view
(eval-after-load 'org '(require 'org-pdfview))

(setq holiday-bahai-holidays nil)
(setq holiday-hebrew-holidays nil)
(setq holiday-islamic-holidays nil)

'(calendar-bahai-all-holidays-flag nil)
'(calendar-christian-all-holidays-flag nil)
'(calendar-hebrew-all-holidays-flag nil)
'(calendar-islamic-all-holidays-flag nil)
'(calendar-mark-holidays-flag t)
'(diary-show-holidays-flag nil)
'(holiday-bahai-holidays nil)
'(holiday-hebrew-holidays nil)
'(holiday-islamic-holidays nil)


(setq org-agenda-include-diary nil)
(setq org-agenda-year-view t)  

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)

(setq org-log-done t)

(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))

;; Custom agenda, trimestrial [1], starting on monday [2], include all [3]
(setq org-agenda-custom-commands
      '(("i" "Custum calendar view" agenda "trimestrial"
         ((org-agenda-span 90)                          ;; [1]
          (org-agenda-start-on-weekday 1)               ;; [2]
          (org-agenda-time-grid nil)                    
          (org-agenda-repeating-timestamp-show-all t) ;; [3]
	  ))  
      ;; other commands go here
        ))


(setq holiday-local-holidays '(
			       (holiday-fixed 1 1 "Jour de l'an")
			       (holiday-fixed 4 2 "Lundi de Pâques")
			       (holiday-fixed 5 1 "Fête du travail")
			       (holiday-fixed 5 8 "8 Mai 1945")
			       (holiday-fixed 5 10 "Jeudi de l'Ascension")
			       (holiday-fixed 5 21 "Lundi de Pentecôte")
			       (holiday-fixed 5 27 "Fête des Mères")
			       (holiday-fixed 6 17 "Fête des Pères")
			       (holiday-fixed 7 14 "Fête Nationale")
			       (holiday-fixed 8 15 "Assomption")
			       (holiday-fixed 1 1 "Toussaint")
			       (holiday-fixed 11 1 "Armistice")
			       (holiday-fixed 1 1 "Noël")
			       ))


(setq org-todo-keywords
  '((sequence "TODO" "INPROGRESS" "WAITING" "DELEGATED" "|" "CANCELLED" "DONE")))

;; TODO entry change  automatically to DONE when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; logging & insertion of closing note
(setq org-log-done 'time)
(setq org-log-done 'note)

;;dependencies
(setq org-enforce-todo-dependencies t)

;; fast todo
;;(setq org-use-fast-todo-selection t)
;;(setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")


;; Use `org-store-link' to store links, and `org-insert-link' to paste them
(setq org-mu4e-link-query-in-headers-mode nil)

;; Capture templates for: Quick captures, Phone Calls, Meetings, TODO tasks, Deadlines and Scheduled things
(setq org-capture-templates'
	(("n" "Quick captures" entry (file+headline "~/org/notes.org" "Quick Captures")
	 "* %? \n %U \n")

	 ("r" "Meetings" entry (file+headline "~/org/notes.org" "Meetings")
	 "* Meeting %? %U :MEETING:\n\n" :org-read-date nil t \"+0d\" :clock-in t :clock-resume t)

	 ("p" "Phone" entry (file+headline "~/org/notes.org" "Phone Calls")
	 "* PHONE %? %U :PHONE:\n\n" :org-read-date nil t \"+0d\" :clock-in t :clock-resume t)

	("t" "Todo Work" entry (file+headline "~/org/work.org" "Tasks")
	 "* TODO %? %a \n SCHEDULED: %(org-insert-time-stamp ()) \n")
	 
	("d" "Deadline" entry (file+headline "~/org/work.org" "Deadlines")
	 "* %? %a \n DEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+0d\")) \n")	

	("s" "Scheduled" entry (file+headline "~/org/work.org" "Scheduled")
	 "* %? %a \n %(org-insert-time-stamp (org-read-date nil t \"+0d\")) \n")	

	("h" "Todo Home" entry (file+headline "~/org/home.org" "A faire")
	 "* TODO %? %a :home: \n SCHEDULED: %(org-insert-time-stamp ()) \n")

	("a"               ; key
	 "Article"         ; name
	 entry             ; type
	 (file+headline "~/org/references/article-notes.org" "Article")  ; target
	"* %^{Title}  :article: \n:PROPERTIES:\n:Created: %U\n:Link: %A\n:END:\n%i\nBrief description:\n%?"  ; template
	 :prepend t        ; properties
	 :empty-lines 1    ; properties
	 :created t        ; properties
	 )
	 
        ))

;; Org-table made available in other modes
(add-hook 'message-mode-hook 'turn-on-orgtbl)

;;Org-mouse
(require 'org-mouse)

;;Org bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;pdf export
(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

;; user defined functions
(org-add-link-type
 "tag" 'follow-tag-link)

(defun follow-tag-link (tag)
"Display a list of TODOs headline with tag TAG
With prefixe arguments, also display headlines without a TODO keyword."
  (org-tag-view (null current-prefix-arg) tag))
  
;; Org-babel
(org-babel-do-load-languages 'org-babel-load-languages
			     (append org-babel-load-languages
				     '((python . t)
				       (emacs-lisp . t)
				       (julia . t)
				       (shell . t)
				       )))

