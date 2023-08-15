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

;(import (r7rs)
;	(srfi-1)
;	(srfi-13)
;	(srfi-69)
;	(scheme file))

; we define variables of the strings of text, which are unquoted and evaluated
; in the map array definition. should be pretty fast and efficient; we will
; not be reading from disk

; not entirely sure why this huge block actually works..
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

  -Pausanias\n\n")

; variable names here are arbitrary, but we will try to follow text<X><Y>
(define text001 "You're at the start of a winding road, you can see it goes
uphill, but there are trees blocking all view of whats beyond.")
(define text002 "Why even go down this? It doesn't seem scary; just pointless.
Turning over rocks can never lead to good, as far as I know, but I'm just
gone.")

