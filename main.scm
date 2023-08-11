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
(define banner
  "\n\n  There was a city said to be the oldest in the world: Lycosura. the most
notable remains of it are the ruins of the Temple of Despoina

... beside the temple of the Mistress on the right is what is called the Hall,
where the Arcadians celebrate Mysteries, and sacrifice to the Mistress many
victims in generous fashion. Every man of them sacrifices what he possesses.
But he does not cut the throats of the victims, as is done in other
sacrifices; each man chops off a limb of the sacrifice, just that which
happens to come to hand. This Mistress the Arcadians worship more than any
other god, declaring that she is a daughter of Poseidon and Demeter. Mistress
is her surname among the many, just as they surname Demeter's daughter by Zeus
the Maiden. But whereas the real name of the Maiden is Persephone, as Homer
and Pamphos before him say in their poems, the real name of the Mistress I am
afraid to write to the uninitiated

  -Pausanias\n\n go south to begin")

; format for text is textXY
(define text001 "You're at the start of a winding road, you can see it goes
uphill, but there are trees blocking all view of whats beyond.")
(define text002 "Why even go down this? It doesn't seem scary; just pointless.
Turning over rocks can never lead to good, as far as I know, but I'm just
gone.")

; global vars

; initial starting position
(define posX 0)
(define posY 0)

; map setup
; we need a 2d array, so here's some matrix code from the Scheme textbook :^)

; matrix-ref returns the jth element of the ith row.
(define matrix-ref
  (lambda (m i j)
    (vector-ref (vector-ref m i) j)))

; the actual construction of the array
; todo program the rooms - 0 for empty
;(define mmaapp (make-matrix 5 5))
(define mmaapp '#(#(1 1 1 1 1)
		  #(1 1 1 1 1)
		  #(0 1 1 1 1)
		  #(1 1 1 1 1)
		  #(1 1 1 1 1)))

; commands
; we must define the whole list first
(define user-commands '(north south east west xyzzy look help quit))

(define (quit)
  (exit))

(define (help)
  (print "You can\n" user-commands))

(define (north)
  (if (checkbounds (+ posX 1) posY)
    (if (lookahead (+ posX 1) posY)
      (begin (print "moving..")
	     (set! posX (+ posX 1)))
      (print "cant go north"))
    (print "out of bounds")))
(define (south)
  (if (checkbounds (- posX 1) posY)
    (if (lookahead (- posX 1) posY)
      (begin (print "moving..")
	     (set! posX (- posX 1)))
      (print "cant go south"))
    (print "cant go south")))
(define (east)
  (if (checkbounds posX (+ posY 1))
    (if (lookahead posX (+ posY 1))
      (begin (print "moving..")
	     (set! posY (+ posY 1)))
      (print "cant go east"))
    (print "cant go east")))
(define (west)
  (if (checkbounds posX (- posY 1))
    (if (lookahead posX (- posY 1))
      (begin (print "moving..")
	     (set! posY (- posY 1)))
      (print "cant go west"))
    (print "cant go west")))

(define (look . location)
  (case (length location)
    ((0) ;;; Assume the player is asking about the current room
     (print "zero"))
    ((1) ;;; Describe the item that the player is looking at.
     (print "one"))))

(define (xyzzy)
  (print "you did the thing!"))

; end of commands

; lookahead check
(define lookahead
  (lambda (x y)
    (cond ((zero? (matrix-ref mmaapp x y)) '#f))))

; bounds check
(define checkbounds
  (lambda (x y)
    (cond
      ((< x 0) '#f)
      ((< y 0) '#f)
      ((> x 4) '#f)
      ((> y 4) '#f)
      ('#t))))

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
    (print banner)
    (display ">")
    (repl)))

;(main)
