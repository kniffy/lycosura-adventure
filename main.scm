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

; TODO implement MIND command
; also are we stupid for even putting text in the vector, we may need to
; structure our data differently, but thats fuckin pain
; maybe just set the text var names to be the proper coordinates

(import (chicken io)
	(srfi-1)
	(srfi-13))

; text
; for final release, we will eval out the map vector, so as to
; keep things in one file, no need for cond-expand
(cond-expand
  (csi
    (load "text.scm"))
  (compiling
    (declare (uses text))))

; global vars
(define *posX* 0)
(define *posY* 3)
; we lock the user away to room 7,0 if they swear :^)
(define *rude* 0)

; map setup
; we define a 2d vector, and use a ref from the scheme textbook :^)
; the room validity checking is only testing for zero, so we define
; our text within the mmaapp array, and display it once we traverse

; do we actually know how this is oriented? x is vertical
; north seems to be pointing downward, and 0,0 seems to be the top left
; to account for this, our north and south functions are flipped
(define mmaapp `#(#(,text04	,text03	,text01	0	0	0	0	1)	;0
		  #(,text02	0	0	0	0	0	0	0)	;1
		  #(,text05	,text06	,text07	,text08	0	0	0	0)	;2
		  #(0	0	0	,text09	,text10	0	0	0)	;3
		  #(0	0	0	0	,text11	0	0	0)	;4
		  #(0	0	0	0	,text12	0	0	0)	;5
		  #(0	,text16	,text15	,text14	,text13	0	0	0)	;6
		  #(,text18	,text17	0	0	0	0	1	0)	;7
		  #(,text19	0	,text23	,text24	1	0	1	0)	;8
		  #(,text20	,text21	,text22	0	1	0	1	1)	;9
		  #(0	0	0	0	1	0	1	0)	;10
		  #(0	0	0	0	1	0	1	0)	;11
		  #(1	0	1	1	1	1	1	0)	;12
		  #(1	0	1	0	0	0	1	0)	;13
		  #(1	1	1	0	0	0	1	1)	;14
		  #(0	0	1	1	1	0	0	1)	;15
		  #(0	0	0	0	1	0	0	0)))	;16
;		    0	1	2	3	4	5	6	7

; commands
; we must define the whole list of valid cmds
; pos cmd is for debug purposes, remove for release
; did we get all the swears?
(define user-commands '(north south east west xyzzy mind help quit exit pos))
(define swears '(fuck shit asshole)) ; todo dictionary of swearing

(define (pos)
  (print *posX* "," *posY*))

(define (quit)
  (exit))

(define (help)
  (print "You can\n" user-commands))

; directions
(define (north)
  (if (and (checkbounds (- *posX* 1) *posY*) (lookahead (- *posX* 1) *posY*))
      (begin (set! *posX* (- *posX* 1))
	     (ptext))
      (display "cant go north")))
(define (south)
  (if (and (checkbounds (+ *posX* 1) *posY*) (lookahead (+ *posX* 1) *posY*))
      (begin (set! *posX* (+ *posX* 1))
	     (ptext))
      (display "cant go south")))
(define (east)
  (if (and (checkbounds *posX* (+ *posY* 1)) (lookahead *posX* (+ *posY* 1)))
      (begin (set! *posY* (+ *posY* 1))
	     (ptext))
      (display "cant go east")))
(define (west)
  (if (and (checkbounds *posX* (- *posY* 1)) (lookahead *posX* (- *posY* 1)))
      (begin (set! *posY* (- *posY* 1))
	     (ptext))
      (display "cant go west")))

; procedure to print the extra text
; uhh should we have text var names based on position?
(define (mind . location)
  (case (length location)
    ((0) ;;; Assume the player is asking about the current room
     (display "zero"))
    ((1) ;;; Describe the item that the player is looking at.
     (display "one"))))

; TODO what should xyzzy do?
(define (xyzzy)
  (display "you did the thing!"))

; end of commands

; boring functions

; print the room text
(define (ptext)
  (if (string? (matrix-ref mmaapp *posX* *posY*))
    (display (matrix-ref mmaapp *posX* *posY*))
    (display "no text here?")))

; saves us when theres not text set for the area
(define (lookahead x y)
  (cond
    ((string? (matrix-ref mmaapp x y)) '#t)
    ((zero? (matrix-ref mmaapp x y)) '#f)
    ((not (zero? (matrix-ref mmaapp x y))) (void))))

; note if the check is the same size as the map
(define (checkbounds x y)
  (cond
    ((< x 0) '#f)
    ((< y 0) '#f)
    ((> x 16) '#f)
    ((> y 7) '#f)
    ('#t)))

; matrix-ref returns the jth element of the ith row.
(define (matrix-ref m i j)
  (vector-ref (vector-ref m i) j))

(define (checkeof x)
  (if (eof-object? x)
    (quit)
    x))

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
  (map string->symbol (string-tokenize (string-downcase (checkeof (read-line))))))

(define (run-command command)
  ;;; Run the users command.
  (if (> (length command) 0)
      (eval command)
      (display "Sorry I didn't understand that")))

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
    (display "\n> ")
    (repl)))

; main loop here
(define (main)
  (begin
    (display banner)
    (display text00)
    (display "\n> ")
    (repl)))

(main)
