; we define variables of the strings of text, which are unquoted and evaluated
; in the map array definition. should be pretty fast and efficient; we will
; not be reading from disk

(declare (unit text))

; should we format to 80col?

; there is not really a nice way to do multi-line strings, this maybe breaks
; on other Schemes, if in doubt use Chicken

(define banner #<<END
DEVELOPMENT VERSION CIRCA NOV. 2024

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
END
)

; variable names here are arbitrary, but we'll try to follow the convention:
; each tile area is assigned a number 1-64, refer to the chart for positioning
; extra text syntax is text<num>-<b>
(define text01 #<<END
You're at the start of a winding road, you can see it goes uphill, but there
are trees blocking all view of whats beyond.

Why even go down this? It doesn't seem scary, just pointless. Turning over
rocks can never lead to good, as far as I know, but I'm just gone.

END
)

(define text02 #<<END
All the paths I could have gone down, yet I'm on this one somehow; what were
down those roads?

END
)

(define text03 #<<END
A turn is in the distance, still can't see beyond though.

END
)

(define text04 #<<END
You're at the curve, the road continues south.. Maybe turn back?

END
)

(define text05 #<<END
Plans never seem to work out, but we'll get where we're going, one step at a
time. There's freedom in that, moving forward, casting aside weights.

END
)

(define text06 #<<END
There's so much to dig up from the past - sparkling rubies or horrifying shit
that ought to be forgotten. Was there a sign back there? How far have we gone?

END
)

(define text07 #<<END
A great emptiness is here, where it was once meaningful. What might've been,
or what was, here we are now.

END
)

(define text08 #<<END
You read somewhere the nature of the animal sacrifices here.. instead of
outright killing, limbs would be cut off - why would the Mistress make it so?

END
)

(define text09 #<<END
A brilliant blue butterfly suddenly flies past. Is it actually so empty? Or is
only the mind empty. You're rounding a bend now, still no sight at whats ahead

END
)

(define text10 #<<END
How many lives have you lived? How many were here in the past - the infinite
place.

END
)

(define text11 #<<END
You're seeking peace - freedom from chaos as much as worry, but how is peace
under stone?

END
)

(define text12 #<<END
It's very hot today, and humid.

END
)

(define text13 #<<END
It doesn't work like that. 10 more days til I'm one year older, in the valley
- will the abyss look back

END
)

(define text14 #<<END
In the past it's like I was asleep, totally unaware of being so, but I can't
even say when waking up happened, or if it even did happen, so I must still be
asleep. I'm just gone.

END
)

(define text15 #<<END
A bit hungry now.

END
)

(define text16 #<<END
What is the Mistress' real name? If only one could still join the Mysteries
and find out

END
)

(define text17 #<<END
How did we end up at this path? Love or something less, maybe. No one else
will be here.

Running away or finding something more - is there a difference

END
)

(define text18 #<<END
Why did you come to this place? What are you doing here? I just had to run
away, which worked for a while, but there's that void.

END
)

(define text19 #<<END
A friend of mine told me once: he had a connection with a girl in the early
days of the internet. It was their habit to talk every day, til one day he
didn't get online for whatever reason.. he never saw her online again.

END
)

(define text20 #<<END
Nobody knows when I'm being serious nobody wants you here, go home. Beyond
the traditional obscurity and weariness in my life, it's mystery.

Til I see you again

END
)

(define text21 #<<END
A couple of birds fly by overhead. You still can't see much - how long is this
road? A bit unnerving with just trees all around, but it's calm and serene
here.

END
)

(define text22 #<<END
Where did we leave the car? Or was there one? Difficult listening at first;
so, timeless.

END
)

(define text23 #<<END
You might think you know what you don't. I bet your brain is broken because
you're a person and your brain will try to do what which we can't.

END
)

(define text24 #<<END
Is this place a graveyard? Hopefully just ruins..

END
)

(define text25 #<<END
You're missing your oldest friend
- you dont even know what became of them.
Maybe they're mad at you, or at worst not even alive anymore.

Or, they're just busy living their life, having moved on.

END
)

(define text26 #<<END
Perhaps they'll call up some day, and it'll be like old times again

or.. not

END
)

(define text27 #<<END
You're all the way out here now, looking for god knows what, away from those
who love you

END
)

(define text28 #<<END
You hear a ping on your phone.

Looking at it, theres no awaiting notifications; just a phantom

END
)

(define text29 #<<END
So tense having thought of this, why does shit like this pop up out here in
the wilderness?

END
)

(define text30 #<<END
Another bird flies by.

END
)

(define text31 #<<END
Fragmentation - is it life in ruins, or the ruins in ruins?

What does any of this add up to being?

END
)

(define text32 #<<END
Are the spaces in between wounds? - whatever, it doesn't really matter does
it, you're out here right now.

END
)

(define text33 #<<END
You see a fractured piece of something by the path - the hand of a statue?
Chunk of marble whatever it is

END
)

(define text34 #<<END
What are you rushing for? Why hurry?
Once again, why did you come to this place?

END
)

(define text35 #<<END
What will home be like once you're through these ruins - at some point soon,
you'll just be there with your thoughts, trying to sleep - still there in your
mind after all this travel getting here and back home. Will you steal a
souvinir to bring back? Not that many would care to see a rock, or ask why
you're walking around with one.

END
)

(define text36 #<<END
Time is ticking, is it getting close?

END
)

(define text37 #<<END
You hate being seen, maybe thats a piece of why you're here.

Nobody to see you out here, but the pretty picture maybe isnt so pure.

END
)

(define text38 #<<END
Is anyone's grave out here you wonder.

Surely there must be, but no markings remain. How did the Lycosurians practice
funerary rites? What became of them.

END
)

(define text39 #<<END
You're thinking back to those you'd want to see again

END
)

(define text40 #<<END
Living in a loop now. Are we back at the start?
Was being hit better or worse than neglect?

Silence as an owl flies past you.
It lands on a perch, glances knowingly, then looks away.

You're still completely motionless. Are you holding your breath?

END
)

(define text41 #<<END
Turn back already, there's nothing here.

END
)

(define text42 #<<END
Your friends want you to hang out, but you have some trepidation.
What if it's weird? They don't seem to want to reach out..

END
)

(define text43 #<<END
Why were you so angry coming back home? There ought to be love right?
Though they say familiarity breeds contempt, what are you running from?
  - it means nothing to me
  . she probably missed you
  - nothing

Should there be guilt for feeling indifference?
END
)

(define text44 #<<END
You can't resurrect a lost past - were you actually happy then?

Am I telling you this, or myself

END
)
