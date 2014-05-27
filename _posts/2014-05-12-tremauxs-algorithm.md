---
layout: post
title: Tremaux's Algorithm
chapter: Interlude
blurb: |
  In which we interrupt the story to ask Dr. Smockwhitener a few questions,
  and maybe suggest something unfortunate in Fabian's near future.
previous_chapter: /2014/05/05/first-great-secret
next_chapter: /2014/05/27/demons-in-the-details
scripts:
  - /js/tremaux-minified.js
script: |
  window.onload = function() { generateTremaux("tremaux"); };
---

*Ahem. Dr. Smockwhitener?*

Wait, what's that? Who's there?

*Over here. Here. No, sir. Look--no. Here. Outward.*

Outward? Oh, for--it's you. The narrator. What's-his-name.

*Jamis, sir.*

Right. Odd name, that, but I suppose you fancy it.

*This, coming from a guy named "Basil Smockwhitener"?*

Touché. Anyhow, haven't seen you around recently. Is there a particular reason you're interrupting this first lesson with my new apprentice?

*I just thought it was a little mean of you to mention Tremaux's algorithm without explaining it. Any chance you'd like to elaborate a bit, perhaps for the benefit of our readers?*

What? You mean people are actually *reading* this?

*Apparently, yes.*

That's...rather baffling.

*They do say that there's no accounting for taste, sir.*

Hmm. Very well, very well. Tremaux's, then?

*If it's not too much trouble.*

All right. That would be Charles Pierre Trémaux. If memory serves, he was a wizard from your side--some engineering-type chap who was building those thingies you have that send messages...the ones with all the beeps and dots and whatnot...

*Telegraph?*

That's it, that's it. Telegraph. It was something like 150 years ago. He was building those telegraph system thingies, and somehow hit on a method for solving mazes. Serendipity, and all that. It's quite a simple strategy, and as I said to Fabian, the method works even when there are loops in the maze. Cycles.

*How?*

It's really pretty remarkable! You see, he was one of the first to discover the depth-first search--

*Oh, ah, actually, we haven't covered graphs and stuff yet, so if you wouldn't mind keeping the explanation a bit non-technical...*

How the devil--? You want me to explain Tremaux's algorithm, and you haven't even covered graphs yet?

*Not yet, sir. That'll come in around chapter four, while Fabian is languishing in the dungeon.*

Well, that's... Wait. The dungeon?! What does that scoundrel do this time?

*Ah, heh. Ahem. Actually, can we just pretend I didn't say that...?*

Hm.

*Please, sir, if you could just go back to telling about Tremaux's algorithm...*

... Fine. But don't think I've forgotten about the dungeon.

*Thank you, sir.*

Hmph. Anyway, you remember about the wall-following algorithm?

*Yes, sir. That's the method you showed Fabian, where you choose a wall and follow it to the exit.*

Just so, but what I told Fabian was not entirely accurate regarding how wall-following behaves when there are cycles. It will actually do just fine as long as two other conditions hold. First, the entrance and exit must both be on the exterior wall of the maze, and second, you must be *following* an exterior wall of the maze. If either of those aren't true when the maze contains cycles, you can't be guaranteed to find your way out. Here, take a look at this diagram. It shows a maze with cycles, where the exit is in the middle. Can you see how wall-following would never get you there?

{% include figure.html width="300" height="276" image="001a-wall-following.jpg" alt="Wall-following with cycles" %}

*Ah, yes. Because the middle is disconnected from the exterior walls--like an island. So following the wall would just take you back to where you started.*

Precisely. But as I was saying, Tremaux's algorithm has no such weakness. All you need to be able to do is mark passages that you've taken, somehow.

*Like, draw a symbol or something on the ground?*

That would do, certainly. Even just hanging a ribbon at an intersection. Something to indicate which paths you've followed.

*That's it?*

Well, no. That's just the one requirement. Assuming you have some way to mark a path the algorithm itself works like this:

**First**, you walk until you reach an intersection.

{% include figure.html width="300" height="371" image="001a-walk-to-intersection.jpg" alt="Tremaux's -- step 1" %}

**Then**, if the intersection hasn't been seen before--

*Which you'd know, because you'd have marked it, right?*

--Correct. And stop interrupting.

*Sorry.*

As I was saying, if the intersection hasn't been seen before, mark the intersection somehow, and then walk down one of the passages at random.

{% include figure.html width="300" height="371" image="001a-unmarked-intersection.jpg" alt="Tremaux's -- step 2 (unmarked intersection)" %}

Be sure to mark which passage you chose, too.

*Why's that?*

It'll be clear in a moment, but it's basically to know which passages at a given intersection haven't been followed yet. You'll see.

*I'll be patient.*

Good. Now, if the intersection *had* been seen before--if you find a mark there when you arrive--then you treat it like a dead-end instead. Just turn yourself around and retrace your steps.

{% include figure.html width="300" height="371" image="001a-marked-intersection.jpg" alt="Tremaux's -- step 2 (marked intersection)" %}

*Hokey-Pokey-style. Got it.*

I...don't even want to know what kind of dark magic you've invoked with this "Hokey-Pokey".

*It's not-- oh, never mind. Please, continue.*

So you retrace your steps until you come to any intersection that has a passage you've not followed yet. Or, as wizards say, a passage that hasn't been *visited* yet. At that point, you would take one of those unvisited passages instead--one that wasn't marked. This, if you'll recall, is why you marked that first passage you chose, and why you should mark the one you choose this time, too.

{% include figure.html width="300" height="371" image="001a-retracing.jpg" alt="Tremaux's -- step 3" %}

*I see. And what's next?*

That's it! Just those four rules. Walk until you reach an intersection. If the intersection hasn't been visited, mark it and choose a passage at random. If it *has* been visited, treat it like a dead-end. And lastly, when retracing your steps, take any unvisited passages you encounter along the way.

*And that'll get you out of the maze?*

Guaranteed. As long as there *is* a solution, Tremaux's algorithm will find it. Maybe not very quickly, or very efficiently, but it'll find it.

*Fascinating! Thank you for the explanation.*

My pleasure.

*And, one last thing...if it's not too much trouble...*

Yes?

*Any chance you could demonstrate the algorithm? For the readers, I mean?*

Did the figures I drew not come through?

*Oh, yes they did, and they were lovely. Thank you. But I was wondering if you could show us something a bit more..ah...dynamic.*

Ah-ha. You're one of *those*, aren't you?

*Sir?*

A thrill-seeker. Looking out for flashy tricks. Into all the hand-waving, magic words, rabbits-from-hats, that sort of thing.

*No, sir, not at all--*

Fine, fine. If you want a show, I'll give you a show. Here. This ought to demonstrate how Tremaux's works. Just tap the buttons. Should be self-explanatory.

*Got it. Thank you, sir!*

Yes, yes. Now off with you. I need to start thinking about how to get Fabian out of this dungeon he's apparently going to find himself in.

<div class="figure">
  <div>
    <a href="javascript:solveTremaux('tremaux')" class="action">solve</a>
    <a href="javascript:generateTremaux('tremaux')" class="action">new</a>
    <canvas id="tremaux" width="400" height="400"></canvas>
  </div>
  <p class="caption">
    The <span style="color:#955;font-weight:bold;">red</span> square is the starting point.<br />
    The <span style="color:#595;font-weight:bold;">green</span> is the destination.<br />
    Paths that are <span style="color:555;font-weight:bold;">gray</span> have been retraced.<br />
    The <span style="color:#995;font-weight:bold;">yellow</span> path is the proposed solution.
  </p>
</div>
