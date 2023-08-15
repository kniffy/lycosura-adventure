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

; bits taken from:
; https://github.com/W1r3W0lf/textAdventure/blob/master/prototypes/box_land/box.scm
; https://github.com/naver/lispe/blob/master/examples/patterns/minizork_en.lisp

; https://tildas.org.

(import (r7rs)
	(srfi-1)
	(srfi-13)
	(srfi-69)
	(scheme file))

; text
(load "data.scm")

; global vars
(define posX 0)
(define posY 0)
(define rude 0)

; map setup
; we define a 2d array, and use a ref from the scheme textbook :^)
; the room validity checking is only testing for zero, so we define
; our text within the mmaapp array, and display it once we traverse

; do we actually know how this is oriented?
; north seems to be pointing downward, and 0,0 seems to be the top left
; bottom left corner is 4,0
(define mmaapp `#(#(,text001 1 1 1 1 1)
		  #(1 1 1 1 1 1)
		  #(0 1 1 1 1 1)
		  #(1 1 1 1 1 1)
		  #(1 1 1 1 1 1)
		  #(1 1 1 1 1 1)))

; commands
; we must define the whole list of valid cmds
(define user-commands '(north south east west xyzzy look help quit))

(define (quit)
  (exit))

(define (help)
  (print "You can\n" user-commands))

; todo cleanup a bit
(define (north)
  (if (and (checkbounds (+ posX 1) posY) (lookahead (+ posX 1) posY))
      (begin (print "moving..")
	     (set! posX (+ posX 1))
	     (iuyt))
      (print "cant go north")))
(define (south)
  (if (and (checkbounds (- posX 1) posY) (lookahead (- posX 1) posY))
      (begin (print "moving..")
	     (set! posX (- posX 1))
	     (iuyt))
      (print "cant go south")))
(define (east)
  (if (and (checkbounds posX (+ posY 1)) (lookahead posX (+ posY 1)))
      (begin (print "moving..")
	     (set! posY (+ posY 1))
	     (iuyt))
      (print "cant go east")))
(define (west)
  (if (and (checkbounds posX (- posY 1)) (lookahead posX (- posY 1)))
      (begin (print "moving..")
	     (set! posY (- posY 1))
	     (iuyt))
      (print "cant go west")))

; todo define look to print optional extra text for areas eg. the rude room
(define (look . location)
  (case (length location)
    ((0) ;;; Assume the player is asking about the current room
     (print "zero"))
    ((1) ;;; Describe the item that the player is looking at.
     (print "one"))))

(define (xyzzy)
  (print "you did the thing!"))

; end of commands

; boring functions

; print the room text
(define (iuyt)
  (if (string? (matrix-ref mmaapp posX posY))
    (print (matrix-ref mmaapp posX posY))
    (print "no text here?")))

(define (lookahead x y)
  (cond
    ((string? (matrix-ref mmaapp x y)) '#t)
    ((zero? (matrix-ref mmaapp x y)) '#f)
    ((not (zero? (matrix-ref mmaapp x y))) (void))))

(define (checkbounds x y)
  (cond
    ((< x 0) '#f)
    ((< y 0) '#f)
    ((> x 4) '#f)
    ((> y 4) '#f)
    ('#t)))

; matrix-ref returns the jth element of the ith row.
(define (matrix-ref m i j)
  (vector-ref (vector-ref m i) j))

(define (in item list)
  ;;; Tells you if an item is in a list or not
  (cond ((member item list) #t) (else #f)))

(define (set-alist-value key new-value alist)
  ;;; Return an alist with the updated value
  (alist-cons key (list new-value) (alist-delete key alist)))

(define (value item alist)
  ;;; Returns the value from an alist
  (cadr (assoc item alist)))

; todo we need to check for #!eof or hope the user doesnt ctrl-D
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
    (print banner)
    (display ">")
    (repl)))

(main)
