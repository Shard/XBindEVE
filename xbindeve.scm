;;;; xbindeve.scm --- Handling keybinds for EVE Online for Linux X11
;;;; Copyright (C) 2020 Mark Beukers <http://github.com/shard/xbindeve>
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation, either version 3 of the License, or
;;;; (at your option) any later version.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(use-modules (ice-9 popen)) ; open-input-pipe
(use-modules (ice-9 rdelim)) ; read-line
(use-modules (rnrs io ports)) ; ports?
(use-modules (rnrs lists)) ; not needed due to srfi-1?
(use-modules (srfi srfi-1)) ; lists

;; Binds CTRL + 1-9
(define eve-active (make-list 9 #nil))

;; Debug/Stub functions
;; (define run-command (lambda (cmd) (display (string-append "run-command: " cmd "\n")) (system cmd)))
;; (define run-command system)

;; Utility
(define eve-get-character-pos
  (lambda (name)
    (list-index list? (map (lambda (x) (member name x)) eve-accounts))))

(define eve-pos-to-character (lambda (pos) (list-ref eve-active pos)))

(define eve-parse-name (lambda (line) (substring line (+ 6 (string-contains line "EVE - ")))))

;; Main functions
(define eve-sync
  (lambda ()
    ;; Open a pipe to wmctrl to get all x11 windows and read each line
    (let ((port (open-input-pipe "wmctrl -l")))
      (do ((line "" (read-line port)))
          ((eof-object? line))
        ;; Windows matching will be added to the list according to position
        (if (string-contains line " EVE - ")
            (list-set! eve-active (eve-get-character-pos (eve-parse-name line)) (eve-parse-name line))))
      (close-pipe port))))

(define eve-open-account
  (lambda (character)
    (run-command (string-append "wmctrl -R '" character "'" ))))

(define eve-open
  (lambda (pos)
    (begin
;;      (eve-sync)
      (let ((character (eve-pos-to-character pos)))
        (if (string? character) (eve-open-account character)))
      )))
