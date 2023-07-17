; this is a basic text walking sim, related to the Lycosurian Mysteries,
; and meant to be played via telnet/ssh

; it was planned to be a promotional tie in with the album release, but
; the decision was made to cancel, given the basis of the project was a
; deprecated python bbs daemon package, not to mention efforts needed to
; be focused on actually finishing the music.. 

; so here we are a couple years later, maybe listen to the music while
; playing this :^)

; when compiled and placed in /bin or similar, it is meant to be called
; as a user's login shell

; https://tildas.org.

(import (r7rs)
	(srfi-1)
	(srfi-13)
	(srfi-69)
	(scheme file))

; set up and definitions
; TODO: strings containing the descriptions, etc
(define area
  (vector '1 '0 '1))

(define user-commands '(north south east west xyzzy look help quit))
; we need to define the list of actions the user can do
; and read the users text:
; north, south, east, west, xyzzy, look, help, quit
; do we need a whole parser, or just a match in a lookup table?

(define (quit)
  (exit))

(define (help)
  (print "You can\n" user-commands))

(define (look . location)
  (case (length location)
    ((0) ;;; Assume the player is asking about the current room
     (print "zero"))
    ((1) ;;; Describe the item that the player is looking at.
     (print "one"))))

(define (in item list)
  ;;; Tells you if an item is in a list or not
  (cond ((member item list) #t) (else #f)))

(define (set-alist-value key new-value alist)
  ;;; Return an alist with the updated value
  (alist-cons key (list new-value) (alist-delete key alist)))

(define (value item alist)
  ;;; Returns the value from an alist
  (cadr (assoc item alist)))

(define (get-command)
  ;;; Gets the command from the user and turns it into a list
  (map string->symbol (string-tokenize (string-downcase (read-line)))))

(define (run-command command)
  ;;; Run the users command.
  (if (> (length command) 0)
      (eval command)
      (print "Sorry I didn't understand that")))

(define (filter-command command filter_list)
  ;;; Removes all words in the command that are not in the filter list. Preserves order of remaining words.
  (filter
   (lambda (x)
     (in x filter_list))
   command))

(define (repl)
  ;;; The REPL for user commands
  (let ((input (filter-command (get-command) user-commands)))
    (run-command input)
    (display ">")
    (repl)))

; main loop here
(define (main)
  (begin
    (print "Welcome to box land.\nThis is a prototype of a text adventure.")
    (display ">")
    (repl)
    ))

(main)
