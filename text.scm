; we define variables of the strings of text, which are unquoted and evaluated
; in the map array definition. should be pretty fast and efficient; we will
; not be reading from disk

; variable names here are arbitrary, but we'll try to follow the convention:
; each tile area is assigned a number 1-64, refer to the chart for positioning
; extra text syntax is text<num>b

; there is not really a nice way to do multi-line strings, this maybe breaks
; on other Schemes, if in doubt use Chicken

; TODO we must perform condensation surgery, we have less than 60 rooms.
; also someone else shows up at some point, and we need the ending
; we meet despina in a dream

; please mind the newlines :^)

(declare (unit text))

(define banner #<<END
DEVELOPMENT VERSION CIRCA DEC. 2024

There was a city said to be the oldest in the world: Lycosura.
The most notable remains of it are the ruins of the Temple of Despoina

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

(define text00 #<<END

You're at the start of a winding road.
You can see it goes uphill, but there are trees blocking all view of what's
beyond.

Up there somewhere are the ruins.

Type [NORTH, SOUTH, EAST, WEST] to move, or EXIT to give up now.

Sometimes you'll have extra thoughts in your MIND

END
)

(define text01 "a")

(define text01b #<<END
Why even go down this? It doesn't seem scary, just pointless.
Turning over rocks can never lead to good, as far as I know.

All the paths I could have gone down, yet I'm on this one somehow;
what were down those other roads?

END
)

(define text02 "")

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

There's so much to dig up from the past - sparkling rubies or horrifying shit
that ought to be forgotten. Was there a sign back there? How far have we gone?

END
)

(define text06 #<<END
A great emptiness is here, where it was once meaningful. What might've been,
or what was, here we are now.

A brilliant blue butterfly suddenly flies past. Is it actually so empty? Or is
only the mind empty. You're rounding a bend now, still no sight at whats ahead

END
)

(define text07 #<<END
How many lives have you lived? How many were here in the past - the infinite
place.

You're seeking peace - freedom from chaos as much as worry, but how is peace
under stone?

END
)

(define text08 #<<END
It's very hot today, and humid.

10 more days til I'm one year older, in the valley
- will the abyss look back

END
)

(define text09 #<<END
In the past it's like I was asleep, totally unaware of being so, but I can't
even say when waking up happened, or if it even did happen, so I must still be
asleep. 

What is the Mistress' real name? If only one could still join the Mysteries
and find out

END
)

(define text10 #<<END
How did we end up at this path? Love or something less, maybe. No one else
will be here.

Running away or finding something more - is there a difference

Why did you come to this place? What are you doing here? I just had to run
away, which worked for a while, but there's that void.

END
)

(define text11 #<<END
A friend of mine told me once: he had a connection with a girl in the early
days of the internet. It was their habit to talk every day, til one day he
didn't get online for whatever reason.. he never saw her online again.

END
)

(define text12 #<<END
Nobody knows when I'm being serious nobody wants you here, go home. Beyond
the traditional obscurity and weariness in my life, it's mystery.

Til I see you again

A couple of birds fly by overhead. You still can't see much - how long is this
road? A bit unnerving with just trees all around, but it's calm and serene
here.

END
)

(define text13 #<<END
Where did we leave the car? Or was there one? Difficult listening at first;
so, timeless.

You might think you know what you don't. I bet your brain is broken because
you're a person and your brain will try to do what which we can't.

END
)

(define text14 #<<END
Is this place a graveyard? Hopefully just ruins..

Haven't been able to sleep lately. Just laying there, mind empty, but while
I'm awake, it's filled with junk. What am I looking for? Is Despina out here?

If she is, not sure what I'd even do..

END
)

(define text15 #<<END
Health keeps getting worse over time - aches just don't go away, senses never
sharpen.

END
)

(define text16 #<<END
You're broken hearted
END
)

(define text17)
(define text18)
(define text19)
(define text20)
(define text21)
(define text22)
(define text23)
(define text24)

; END OF INTRO

(define text29 #<<END
Alienation brought you to this place - but you're the outsider here.
END
)

(define text30 #<<END
Every time you drift off to sleep the Mistress starts to say something..

But she's never in the dream

END
)

(define text31 #<<END
No one else is with you
This part you're on your own

END
)

(define text32 #<<END
You thought things would be better - theres that crushing emptiness, or the
idea of what may have been.

END
)

(define text33 #<<END
Your heart has been closed off for years, so why are you open for this?

END
)

(define text34 #<<END
Thinking on it, let's just turn back. There really can't be any good here..
Please go back, or quit the game

END
)

(define text35 #<<END
Quit!
END
)

(define text36 #<<END
You'll regret finding out..
END
)

(define text37 #<<END
I'm a bad friend, turned to stone. All I can muster to those is silence. Why
did anyone like me?

END
)

(define text38 #<<END
What is ever really the point
END
)

(define text39 #<<END
I found and read an old notebook from college, it was more sad than I remember
 - I was in a daze and suicidal, apparently. How can one not even recall that?
Self protection mechanism maybe perhaps.

END
)

(define text40 #<<END
The point is to live simply and healthy among friends - much else is bullshit,
so why the hell are we here in this land alone? She can't possibly be here.

END
)

(define text41 #<<END
Was it even real? It felt like it at the time, but it's cold and alien now -
or just lifeless?
The worst would be having it happen again, but why though? Can't I be an
unfeeling robot instead?

END
)

(define text42 #<<END
Everything is broken and I don't know how i can fix it - god damn it.
Sometimes I feel like that, but getting older has calmed me down. Less
hormones raging or whatever.

END
)

(define text43 #<<END
You come back after a time and it's different - world kept spinning while your
focus was elsewhere.
What the fuck did I do?

END
)

(define text44 #<<END
Honestly I've just kept falling through the cracks

END
)

(define text45 #<<END
Why the fuck worry about everything, sticking fingers in everything. Leave
well enough alone for once.

END
)

(define text46 #<<END
Refresh my memory - is it all when I came off coldly?

Discrete mathematics suggests things like partitions, or a function with only
integers and no reals.

How many hands have I shaken? Not very many.

Do you hear anything I'm saying?

Fan too loud, it's cold - aphorism
END
)

(define text47 #<<END
You forgot to bring a camera. What will you do with yourself? Can't make it
alone.

END
)

(define text48 #<<END
Was there ever love there? Ladybird.
Don't forget, even though you surely will.

END
)

(define text49 #<<END
Did some archaeology once, listened to music of my youth.. started crying.
Same with photos of us.

END
)

(define text50 #<<END
Am I actually sane? We live in a dream, or so says David Bowie..

Is there enlightenment without suffering?

You are in a very peculiar emotional place.

END
)

(define text51 #<<END
It's afternoon now, light starting to change
END
)

(define text52 #<<END
Was it desire that brought you here? Surely it's not a quest for knowledge.
She won't be here, and wont go with you even if she was.

END
)

(define text53 #<<END
Haven't I met someone new? Am I holding on too tightly? Is loss letting go?
END
)

(define text54 #<<END
I have the urge to just leave my friends - cut ties. They just take me for
granted, ignoring most of what I say. But what would it be like otherwise?
Everyone hyping me up all the time?

END
)

(define text55 #<<END
Being a man is when you notice you aren't shit and you step it up. Not a
matter of age or looks.

END
)

(define text56 #<<END
Way out in the distance there is a hint of something; or is it grams' eyes
seeing things again

END
)

(define text57 #<<END
Gotta feed the dog but he isn't with me now - he's a good boy, probably
missing me being gone.

END
)

(define text58 #<<END
You're missing your oldest friend
- you dont even know what became of them.
Maybe they're mad at you, or at worst not even alive anymore.

Or, they're just busy living their life, having moved on.

END
)

(define text59 #<<END
Perhaps they'll call up some day, and it'll be like old times again

or.. not

END
)

(define text60 #<<END
You're all the way out here now, looking for god knows what, away from those
who love you

END
)

(define text61 #<<END
You hear a ping on your phone.

Looking at it, theres no awaiting notifications; just a phantom

END
)

(define text62 #<<END
So tense having thought of this, why does shit like this pop up out here in
the wilderness?

END
)

(define text63 #<<END
Another bird flies by.

END
)

(define text64 #<<END
Fragmentation - is it life in ruins, or the ruins in ruins?

What does any of this add up to being?

END
)

(define text65 #<<END
Are the spaces in between wounds? - whatever, it doesn't really matter does
it, you're out here right now.

END
)

(define text66 #<<END
You see a fractured piece of something by the path - the hand of a statue?
Chunk of marble whatever it is

END
)

(define text67 #<<END
What are you rushing for? Why hurry?
Once again, why did you come to this place?

END
)

(define text68 #<<END
What will home be like once you're through these ruins - at some point soon,
you'll just be there with your thoughts, trying to sleep - still there in your
mind after all this travel getting here and back home. Will you steal a
souvinir to bring back? Not that many would care to see a rock, or ask why
you're walking around with one.

END
)

(define text69 #<<END
Time is ticking, is it getting close?

END
)

(define text70 #<<END
You hate being seen, maybe thats a piece of why you're here.

Nobody to see you out here, but the pretty picture maybe isnt so pure.

END
)

(define text71 #<<END
Is anyone's grave out here you wonder.

Surely there must be, but no markings remain. How did the Lycosurians practice
funerary rites? What became of them.

END
)

(define text72 #<<END
You're thinking back to those you'd want to see again

END
)

(define text73 #<<END
Living in a loop now. Are we back at the start?
Was being hit better or worse than neglect?

Silence as an owl flies past you.
It lands on a perch, glances knowingly, then looks away.

You're still completely motionless. Are you holding your breath?

END
)

(define text74 #<<END
Turn back already, there's nothing here.

END
)

(define text75 #<<END
Your friends want you to hang out, but you have some trepidation.
What if it's weird? They don't seem to want to reach out..

END
)

(define text76 #<<END
Why were you so angry coming back home? There ought to be love right?
Though they say familiarity breeds contempt, what are you running from?
  - it means nothing to me
  . she probably missed you
  - nothing

Should there be guilt for feeling indifference?
END
)

(define text77 #<<END
You can't resurrect a lost past - were you actually happy then?

Am I telling you this, or myself

END
)

; ending bit
(define endcard #<<END
You've made it to the end - so you understand now, the Lycosurians died a long
time ago, there's nothing to discover.

We'll still be here after you leave.

END
)
