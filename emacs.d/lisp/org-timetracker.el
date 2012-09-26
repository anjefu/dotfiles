;; Released under the WTFPL http://sam.zoy.org/wtfpl/
;; David Bremner 2008/12/30

(provide 'org-timetracker)

(require 'cal-iso)
(require 'calendar)

(defvar ott-directory
  "root directory for org-timetracker files"
  nil)

(defvar ott-file nil
    "file for this weeks time tracking")

(defvar ott-time-buffer nil
  "buffer for time tracking")


(defun ott-week-in-year ()
  "compute the week of the current year"
  (car (calendar-iso-from-absolute
	(calendar-absolute-from-gregorian
	 (calendar-current-date)))))


(defun ott-current-year ()
  "Return the current year"
  (nth 5 (decode-time)))

(defun   ott-file-name ()
  (let ((root (expand-file-name (and ott-directory org-directory))))
    (concat root
     (format "/%04d/%02d.org" (ott-current-year) (ott-week-in-year)))))



(defun ott-jump-to-time ()
  (interactive)
  (ott-timer-start)
  (setq ott-time-buffer (find-file (ott-file-name))))

(define-key global-map "\C-ct" 'ott-jump-to-time)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; idle timer, copied from emacswiki.org
;; variable for the timer object
(defvar ott-timer-timer nil)

(defvar ott-timer-timeout 900
  "time in seconds before closing down the current clock and starting a new one")
;; callback function
(defun ott-timer-callback ()
  (let ((buf (marker-buffer org-clock-marker))
	(wcf (current-window-configuration)))
    (and buf
	 (progn
	   (switch-to-buffer buf)
	   (goto-char org-clock-marker)
	   (org-clock-out)
	   (org-clock-in)
	   (set-window-configuration wcf)))))

(defun ott-timer-start ()
  (interactive)
  (when (timerp ott-timer-timer)
    (cancel-timer ott-timer-timer))
  (setq ott-timer-timer
          (run-with-idle-timer ott-timer-timeout t #'ott-timer-callback)))

;; stop function
(defun ott-timer-stop ()
  (interactive)
  (when (timerp ott-timer-timer)
    (cancel-timer ott-timer-timer))
  (setq ott-timer-timer nil))


;; from Bastien @altern.org

(defun org-check-running-clock-any-buffer ()
  "Check if any Org buffer contains a running clock.
If yes, offer to stop it and to save the buffer with the changes."
  (interactive)
  (and (bound-and-true-p org-clock-marker)
       (let ((buf (marker-buffer org-clock-marker))
	     (wcf (current-window-configuration)))
	 (when
	     (and buf
		  (y-or-n-p
		   (format "Clock-out in buffer %s before killing it? " buf)))
	   (switch-to-buffer buf)
	   (org-clock-out)
	   (save-buffer))
	 (set-window-configuration wcf))))

(defadvice save-buffers-kill-emacs
  (before org-check-running-clock activate)
  "Check for a running clock before quitting."
  (org-check-running-clock-any-buffer))
