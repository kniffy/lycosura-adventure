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
	;(srfi-69)
	(scheme file))

; text
; for final release, we will redefine the entire map array to the expanded
; full size vector, so as to compile this as a single file
;(load "text.scm")
;(declare (uses text))


; global vars
(define posX 0)
(define posY 3)
; we lock the user away to room 7,0 if they swear :^)
(define rude 0)

; map setup
; we define a 2d array, and use a ref from the scheme textbook :^)
; the room validity checking is only testing for zero, so we define
; our text within the mmaapp array, and display it once we traverse

; do we actually know how this is oriented? x is vertical
; north seems to be pointing downward, and 0,0 seems to be the top left
; to account for this, our north and south functions are flipped
(define prom
  (delay
    (set! mmaapp `#(#(,text04 ,text03 ,text01 0 0 0 0 1)	;0
		  #(,text02 0 0 0 0 0 0 0)	;1
		  #(,text05 ,text06 ,text07 ,text08 0 0 0 0)	;2
		  #(0 0 0 ,text09 ,text10 0 0 0)	;3
		  #(0 0 0 0 ,text11 0 0 0)	;4
		  #(0 0 0 0 ,text12 0 0 0)	;5
		  #(0 ,text16 ,text15 ,text14 ,text13 0 0 0)	;6
		  #(,text18 ,text17 0 0 0 0 1 0)	;7
		  #(,text19 0 ,text23 ,text24 1 0 1 0)	;8
		  #(,text20 ,text21 ,text22 0 1 0 1 1)	;9
		  #(0 0 0 0 1 0 1 0)	;10
		  #(0 0 0 0 1 0 1 0)	;11
		  #(1 0 1 1 1 1 1 0)	;12
		  #(1 0 1 0 0 0 1 0)	;13
		  #(1 1 1 0 0 0 1 1)	;14
		  #(0 0 1 1 1 0 0 1)	;15
		  #(0 0 0 0 1 0 0 0)))	;16
;		    0 1 2 3 4 5 6 7
))

; commands
; we must define the whole list of valid cmds
; pos cmd is for debug purposes, remove for release
; did we get all the swears?
(define user-commands '(north south east west xyzzy look help quit pos))
(define swears '(fuck shit asshole)) ; todo dictionary of swearing

(define (pos)
  (print posX "," posY))

(define (quit)
  (exit))

(define (help)
  (print "You can\n" user-commands))

; todo cleanup a bit
(define (north)
  (if (and (checkbounds (- posX 1) posY) (lookahead (- posX 1) posY))
      (begin (set! posX (- posX 1))
	     (ptext))
      (display "cant go north")))
(define (south)
  (if (and (checkbounds (+ posX 1) posY) (lookahead (+ posX 1) posY))
      (begin (set! posX (+ posX 1))
	     (ptext))
      (display "cant go south")))
(define (east)
  (if (and (checkbounds posX (+ posY 1)) (lookahead posX (+ posY 1)))
      (begin (set! posY (+ posY 1))
	     (ptext))
      (display "cant go east")))
(define (west)
  (if (and (checkbounds posX (- posY 1)) (lookahead posX (- posY 1)))
      (begin (set! posY (- posY 1))
	     (ptext))
      (display "cant go west")))

; todo define look to print optional extra text for areas eg. the rude room
(define (look . location)
  (case (length location)
    ((0) ;;; Assume the player is asking about the current room
     (display "zero"))
    ((1) ;;; Describe the item that the player is looking at.
     (display "one"))))

; todo what should xyzzy do?
(define (xyzzy)
  (display "you did the thing!"))

; end of commands

; boring functions

; print the room text
(define (ptext)
  (if (string? (matrix-ref mmaapp posX posY))
    (display (matrix-ref mmaapp posX posY))
    (display "no text here?")))

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
    (display "\n>")
    (repl)))

; main loop here
(define (main)
  (begin
    ;(display banner)
    (display "\n>")
    (repl)))

;(main)





; we define variables of the strings of text, which are unquoted and evaluated
; in the map array definition. should be pretty fast and efficient; we will
; not be reading from disk

; should we format to 80col?

; there is not really a nice way to do multi-line strings, this maybe breaks
; on other Schemes, if in doubt use Chicken

;(declare (unit text))

; not entirely sure why this huge block actually works..
(define banner "DEVELOPMENT VERSION CIRCA JAN. 2024

There was a city said to be the oldest in the world: Lycosura. The most
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

  -Pausanias
")

; variable names here are arbitrary, but we'll try to follow the convention:
; each tile area is assigned a number 1-64, refer to the chart for positioning
; extra text syntax is text<num>-<b>
(define text01 "You're at the start of a winding road, you can see it goes uphill, but there
are trees blocking all view of whats beyond.

Why even go down this? It doesn't seem scary, just pointless. Turning over
rocks can never lead to good, as far as I know, but I'm just gone.
")

(define text02 "All the paths I could have gone down, yet I'm on this one somehow; what were
down those roads?
")

(define text03 "A turn is in the distance, still can't see beyond though.
")

(define text04 "You're at the curve, the road continues south.. Maybe turn back?
")

(define text05 "Plans never seem to work out, but we'll get where we're going, one step at a
time. There's freedom in that, moving forward, casting aside weights.
")

(define text06 "There's so much to dig up from the past - sparkling rubies or horrifying shit
that ought to be forgotten. Was there a sign back there? How far have we gone?
")

(define text07 "A great emptiness is here, where it was once meaningful. What might've been,
or what was, here we are now.
")

(define text08 "You read somewhere the nature of the animal sacrifices here.. instead of
outright killing, limbs would be cut off - why would the Mistress make it so?
")

(define text09 "A brilliant blue butterfly suddenly flies past. Is it actually so empty? Or is
only the mind empty. You're rounding a bend now, still no sight at whats ahead
")

(define text10 "How many lives have you lived? How many were here in the past - the infinite
place.
")

(define text11 "You're seeking peace - freedom from chaos as much as worry, but how is peace
under stone?
")

(define text12 "It's very hot today, and humid.
")

(define text13 "It doesn't work like that. 10 more days til I'm one year older, in the valley
- will the abyss look back
")

(define text14 "In the past it's like I was asleep, totally unaware of being so, but I can't
even say when waking up happened, or if it even did happen, so I must still be
asleep. I'm just gone.
")

(define text15 "A bit hungry now.
")

(define text16 "What is the Mistress' real name? If only one could still join the Mysteries
and find out
")

(define text17 "How did we end up at this path? Love or something less, maybe. No one else
will be here.

Running away or finding something more - is there a difference
")

(define text18 "Why did you come to this place? What are you doing here? I just had to run
away, which worked for a while, but there's that void.
")

(define text19 "A friend of mine told me once: he had a connection with a girl in the early
days of the internet. It was their habit to talk every day, til one day he didn't get online
for whatever reason.. he never saw her online again.
")

(define text20 "Nobody knows when I'm being serious nobody wants you here, go home. Beyond
the traditional obscurity and weariness in my life, it's mystery.

Til I see you again
")

(define text21 "A couple of birds fly by overhead. You still can't see much - how long is
this road? A bit unnerving with just trees all around, but it's calm and serene here.
")

(define text22 "Where did we leave the car? Or was there one? Difficult listening at first;
so, timeless.
")

(define text23 "You might think you know what you don't. I bet your brain is broken because
you're a person and your brain will try to do what which we can't.
")

(define text24 "Is this place a graveyard? Hopefully just ruins..
")

(begin
  (force prom)
  (display banner)
  (main))
