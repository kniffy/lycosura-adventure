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

(import (chicken io))	; we need read-line
(import input-parse)
(import simple-loops)
(import srfi-1)
(import linenoise)
;(import srfi-13)	; maybe we need this in the future

; set up and definitions
; TODO: strings containing the descriptions, etc
(define area
  (vector '1 '0 '1))

(display "You're standing in front of some ruins \n")
(define userinput
  (read-line (current-input-port)))

(define userquit 0)

(define actions
  (list "quit" "exit"))

; main loop here
(do-while (not (string-ci=? "quit" userinput))
  (read-text-line))

;(if (find userinput actions)
;  (display "you matched a thing")
;  (display " you didnt"))

;(do-forever
;  (find userinput actions))
;	  (if (string-ci=? "quit" userinput)
;	    (exit)))

	 ; (if (string-ci=? "hi" userinput)
	  ;  (display "you said hi\n")
	   ; (display "you didnt say hi\n")))



; we need to define the list of actions the user can do
; and read the users text:
; north, south, east, west, xyzzy, look, help, quit
; do we need a whole parser, or just a match in a lookup table?
