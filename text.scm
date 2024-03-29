; we define variables of the strings of text, which are unquoted and evaluated
; in the map array definition. should be pretty fast and efficient; we will
; not be reading from disk

; should we format to 80col?

; there is not really a nice way to do multi-line strings, this maybe breaks
; on other Schemes, if in doubt use Chicken

(declare (unit text))

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

