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

; TODO
; banish helper functions to their own module, they clog our shit up
; implement MIND command
; also are we stupid for even putting text in the vector, we may need to
; structure our data differently, but thats fuckin pain
; maybe just set the text var names to be the proper coordinates

; importing fun things, mind the cond expansions
(cond-expand
  (csi
    (load "func.scm")
    (load "text.scm"))
  (compiling
    (declare (uses text))))

(import func)

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

; for final release, we will eval out the map vector, so as to
; keep things in one file, no need for loading text.scm
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
; did we get all the swears?
(define user-commands '(north south east west xyzzy mind help quit exit pos pos2))
(define swears '(fuck shit asshole)) ; todo dictionary of swearing

; for debugging, remove when GOLD
(define (pos)
  (print *posX* "," *posY*))
(define (pos2)
  (print (cbla *posX* *posY*)))

(define (quit)
  (exit))

(define (help)
  (print "You can\n" user-commands))

; low-level movement procedure
; we take the relative offsets as input
; eg. north -> -1 0
(define (go p q)
  (let ([r (+ *posX* p)] [s (+ *posY* q)])
    (if (cbla r s)
        (begin (set! *posX* r)
               (set! *posY* s)
               (ptext))
        (display "can't go that way"))))

; higher-level movement procedures
; observe how we define our directions here
(define (north) (go -1 0))
(define (east) (go 0 1))
(define (south) (go 1 0))
(define (west) (go 0 -1))

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

; boring functions!

; NOTE that most are put into the func module
; but those that are poking global vars are
; still here

; print the room text
(define (ptext)
  (if (string? (matrix-ref mmaapp *posX* *posY*))
    (display (matrix-ref mmaapp *posX* *posY*))
    (display "no text here?")))

; higher-order help for lookahead+checkbounds
; returns #t or #f if room is valid
(define (cbla v w)
  (and
    (checkbounds v w)
    (lookahead v w mmaapp)))

(define (repl)
  ;;; The REPL for user commands
  (let ((input (filter-command (get-command) user-commands)))
    (run-command input)
    (display "\n> ")
    (repl)))

; end of boring

; main loop here
(define (main)
  (begin
    (display banner)
    (display text00)
    (display "\n> ")
    (repl)))

(main)
