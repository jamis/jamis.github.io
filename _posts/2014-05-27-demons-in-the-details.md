---
layout: post
title: Demons in the Details
chapter: Chapter 2
words: 3809
blurb: >
  Fabian confesses to a youthful dalliance, discovers how flooding a
  maze is like Dijkstra's algorithm, and faces at least two terrifying
  things.
previous_chapter: /2014/05/12/tremauxs-algorithm
next_chapter: /2014/06/09/bitter-roots-growing-tree
scripts:
  - /js/dijkstra-minified.js
script: |
  window.onload = function() { generateDijkstra("dijkstra", 11); };
---

"It's not too late, sir," Fabian said as he eyed the distant castle nervously. "I'm sure we could get back through the maze quickly, and reach that village before dark--"

{% include illustration.html align="right" width="400" height="402" image="002-fabian-looking-at-castle.jpg" alt="Fabian considers curmudgeon castle" caption='Fabian eyed the distant castle nervously...' %}

Basil merely cleared his throat, but it stopped Fabian as surely as a command would have. The wizard stood resolutely beside him at the top of the stairs, tugging distractedly at his voluminous mustaches. His small, dark eyes gazed intensely at his manservant.

"Fabian."

Fabian cringed. "Yes, sir?"

"That's the second time you've suggested we turn back to that village, and I'm beginning to wonder why you're so fixated on it." He stopped suddenly, his eyes widening. "There's a woman, isn't there?"

Fabian stepped back in surprise and nearly fell headlong down the stairs. "What? No! Sir, I--"

"There *is* a woman! I don't know when you'd have managed to get involved with her, but this village thing, and your reaction to the whole dance metaphor--"

"Sir! No, you misunderstand--"

"Do I?" Basil stared curiously at Fabian. "If I've misunderstood, then I certainly apologize, but this fixation on the village is getting tiresome. I'd like to understand what this is all about."

Fabian stood sweating, teetering precariously on the top step without seeming to notice. "I--" he said, and then swallowed noisily. He wiped his forehead with the back of his hand.

"Yes, sir," he finally said. "I will admit that there *was* a woman, once. She--she was an artist living in that village. This was years ago, before I entered your employ. I doubt she's even still there. And even if she was, I'm sure she'd never want to see *me* again." He paused then, and a thoughtful, pained look came into his eyes.

An uncharacteristically sympathetic look settled onto Basil's face. "What happened?" he asked. "Would you like to--that is, I'm here if--I mean-- Oh, bother. I'm terrible at this." He sighed. "Do you want to talk about it?"

Fabian shrugged. "As I said, sir, it was some time ago. I was a different person, then. Just a boy, really. As for her...well. She was...Anathema."

Basil seemed taken aback. "That seems a bit harsh. What did she do?"

Fabian glanced at the taller man and shook his head. "No, no, sir. Her name. Her name was Anathema."

"As in, 'She Who Must Not Be Named'?"

Fabian exhaled in exasperation. "No, sir. Not like that. That was just her name. When she was born, her parents named her 'Anathema'. Most folks, though, called her Annie."

Basil raised an eyebrow. "Ah, I see. An...odd...choice for a name. I can see why she might prefer a nickname."

"Oh, she didn't. And I never could call her Annie. 'Anathema' seemed to...I don't know...suit her, somehow. She was an artist, after all."

Basil puffed out his mustaches and shook his head. "You've got me very curious now, Fabian."

Fabian shrugged. "There's not much more to tell, sir. I was stupid, and it ended, long ago."

"I see." Basil nodded wisely and stroked his mustaches. After a moment he sighed deeply and patted Fabian on the shoulder. "Well, it's a good thing there's a cure for stupidity then, or we'd all die from it."

"A cure, sir?"

"Certainly. Experience! A bitter pill, for sure, but sovereign for what ails you."

{% include illustration.html align="left" width="400" height="358" image="002-a-bitter-pill.jpg" alt="Experience is a bitter pill." caption='Experience is a bitter pill.' %}

"I must need a larger dose, sir. My condition doesn't seem to be improving."

Basil laughed. "Be careful what you ask for!" He gestured to the second maze that extended from the bottom of the stairs below them. "You might just find yourself with a *double* dose."

Fabian chuckled weakly, but looked relieved. He spoke quickly. "So what are these 'more powerful tricks' you mentioned?"

Basil nodded. "Very well. There was a wizard once--a great wizard. Really a sharp fellow, though he had some strong opinions. Name of [Dijkstra](http://en.wikipedia.org/wiki/Edsger_W._Dijkstra "Edsger W. Dijkstra")."

Fabian sighed. "Now *that's* a name worthy of a wizard."

Basil paused, mouth open, and then narrowed his eyes at Fabian. "What are you implying?"

"Ah." Fabian seemed to realize that he was on thin ice. "I was just--ah--trying to imagine a wizard named 'Fabian', sir. It doesn't have the--um--*magical sound* that 'Dijkstra' has." He licked his lips. "Or 'Basil', of course, sir."

Basil looked blankly at Fabian for a long moment, and then blinked once, slowly. "All right, then." He cleared his throat. &ldquo;Anyway. Dijkstra. He came up with an algorithm for, well, let's just say 'navigating mazes', for now. It's actually useful for a great many things, but we'll keep things simple by starting small.

"What Dijkstra's algorithm will do for us here is find the shortest path through that." Basil nodded toward the maze in front of them. "And, more generally, it will find the shortest path to any point in the maze, from any point of our choosing."

"*Any* point, sir?" Fabian asked, raising an eyebrow. "Is there any reason we wouldn't just choose the entrance?"

"In our situation? No, not really. But the option can be useful."

Fabian nodded. "How does it work?"

Basil reached into his lab coat and withdrew his battered, blue pencil. Fabian cringed.

{% include illustration.html align="right" width="400" height="386" image="002-blue-pencil.jpg" alt="Basil's blue pencil" caption='Basil withdrew his battered, blue pencil.' %}

"Honestly, Fabian," Basil said. "It's just a pencil."

"I beg to differ, sir."

"Beg all you want, then." Basil said, shaking his head. "I tell you, it's just a pencil. It has no innate power or ability of its own, except maybe to write with. Even then, it's not particularly exceptional. For me, it's a focus. You'll want one eventually, too."

"A pencil?"

"If that's what you prefer. I only know a few other wizards who have taken the pencil for their focus. Others choose things like--I dunno--business cards, or hair combs. Mirrors. Broomsticks. Very small rocks. Things like that."

Fabian looked skeptical, but Basil didn't press the point. "Anyway. Here's something to demonstrate how Dijkstra's algorithm works." He sketched a circle on the ground, and a squat cylinder, open on top, appeared there before them. It was about half a meter across, and just a few fingers high.

{% include figure.html width="300" height="237" image="002-empty-container.jpg" alt="Empty cylinder" %}

"Now imagine, Fabian, that we can freeze time itself--make all motion cease--all activity, everything. Raindrops would halt in mid-air, people would abruptly stop in mid-step, thrown balls would hang suspended above the ground."

Fabian nodded appreciatively. "Now *that* would be a useful spell to know, sir," he said. "I could actually get the house completely clean for a change, without *somebody* constantly messing things up behind me."

Basil rolled his eyes. "It's not a real spell, Fabian. I'm asking you to *imagine*."

"Ah." Fabian looked disappointed. "Yes, sir."

"So now, with time frozen like that, I'm going to place a ball of water in the middle of that circle, like a raindrop just before it splashes to the ground." Basil sketched a ball where he'd indicated, and a blue sphere appeared. It caught the light beautifully, like a fist-sized blue gem.

{% include figure.html width="300" height="237" image="002-cylinder-with-ball.jpg" alt="Cylinder with ball of water" %}

"Now, Fabian. If I let time run for just a moment--a half second or so--and then stop it again, what will happen?"

Fabian pointed to the cylinder. "The water will spread out and make a mess."

"All at once? In a half-second?"

Fabian considered. "Well, no, I suppose not, sir. It will *begin* to spread out and make a mess."

"Just so. Observe." Basil gestured with his pencil and the blue sphere sagged abruptly, as if it was ice that was rapidly melting. Just as suddenly, it stopped again, with a frozen puddle of water spread out about a hand-span around it.

{% include figure.html width="300" height="237" image="002-water-step1.jpg" alt="Water beginning to puddle" %}

Basil pointed to the puddle. "And what if I let time run again, just for another half-second?"

"The water will spread out a bit further, sir."

"Exactly. Each step we take in time will see the water spread out a little bit more." Basil gestured with his pencil, two, three, four times, and the pool moved outward a little further each time. "So it will go until it reaches the wall of the circle."

He demonstrated again, starting and stopping time with chopping motions of his hand. It wasn't long before the water was lapping against the walls of the container.

{% include figure.html width="300" height="300" image="002-water-progression.jpg" alt="Progression of the water" %}

"Easy enough, yes?" Basil said. "Now, let's make it a little more interesting." He waved his hand and the water disappeared, and then proceeded to sketch briefly in the air. A semicircular divider appeared within the cylinder, offset slightly from the center. A moment later, a small vertical rod appeared near the convex side of the divider.

{% include figure.html width="300" height="237" image="002-cylinder-with-divider.jpg" alt="Cylinder with divider" %}

"Now, from the center of the circle, Fabian, what would be the shortest path to that rod?"

"Here, sir." Fabian pointed with his finger, tracing a path along the concave side of the divider, and then around the other side.

"Very good," Basil agreed. "I'm going to add the same ball of water again, and let's see if the water agrees with us."

Once again, a shimmering blue sphere appeared in the middle of the circle. Basil proceeded to step through time, chopping with his hand, and causing the water to jerkily flow up against the divider, and then around it, just as Fabian had suggested.

{% include figure.html width="300" height="300" image="002-water-progression2.jpg" alt="Progression of the water, again" %}

Basil waved again and the entire container disappeared. "Now, one more demonstration. What if we had an actual *maze* here?" He sketched rapidly, and labyrinthine walls just a few fingers high appeared on the ground in front of them. "What would happen now, if I were to release that same ball of water in the middle of this maze?"

Fabian smiled. "I think I see it, sir. The water will spread out, following the passages, right? Eventually it'll flood the entire maze."

"Yes, exactly!" Basil looked pleased. "Let's step through it."

He sketched a ball of water in the middle, as before, and then proceeded to make chopping motions with the pencil again. Just as Fabian had predicted, the water moved in fits and starts through the passages until it had eventually filled them all.

<div id="dijkstra-demo" class="figure">
  <div>
    <div class="options">
      Size:
      <a href="javascript:generateDijkstra('dijkstra', 11)" class="option">small</a>
      <a href="javascript:generateDijkstra('dijkstra', 15)" class="option">medium</a>
      <a href="javascript:generateDijkstra('dijkstra', 21)" class="option">large</a>
      <a href="javascript:generateDijkstra('dijkstra', 29)" class="option">xl</a>
      <a href="javascript:generateDijkstra('dijkstra', 39)" class="option">xxl</a>
    </div>
    <canvas id="dijkstra" width="400" height="400"></canvas>
    <a href="javascript:updateDijkstra('dijkstra')" class="action">step</a>
    <a href="javascript:runDijkstra('dijkstra')" class="action">run</a>
    <a href="javascript:resetDijkstra('dijkstra')" class="action">reset</a>
  </div>
  <p class="caption">
    Tap the "step" button to step through time, just like Basil!<br />
    The <span style="color:#955;font-weight:bold;">red</span> square is the starting point.<br />
    The <span style="color:#aaf;font-weight:bold;">blue</span> squares are the &ldquo;wave front&rdquo;.<br />
    Darker squares are further from the starting point than lighter squares.
  </p>
</div>

Fabian clapped delightedly. "I do see it, sir! Some of those dead-ends were filled later than others, which means that the path the water took to reach them must have been longer than the paths that filled sooner, right? So the sooner the water filled the path, the shorter the path was?"

"Just so!" Basil clapped, too. "You've got it! That's Dijkstra's algorithm in a nutshell. Paths are found by stepping at a constant rate, with the algorithm keeping track of how far each point is along the front of the 'wave'."

Fabian nodded, grinning.

Basil wagged the pencil warningly. "Don't get too comfortable, however. The demons are in the details, as ever. Water can't tell us, after the fact, which path it took, or how long the path was. For this, we need to recruit some help."

"'Recruit'?"

"Just so. We need to summon a demon."

Fabian yelped at that, but Basil waved his pencil sharply before he could protest. There was a flash of ominous red light and an enormous billowing of acrid smoke. The sharp smell of sulfur filled the air.

In a panic, coughing desperately and eyes stinging, Fabian frantically fanned the evil-smelling smoke away, trying to see what Basil's magic had done. His hands seemed to have little effect, though, and while the foul vapor yet clouded the air, a deep, grating voice boomed from in front of them. "Who summons me? Answer, mortal, or feel my wrath!"

The ground shook slightly, too, which struck Fabian as patently unfair.

Basil patted him on the shoulder. "Oh, don't listen to him," he said. "He likes to bluster, but his wrath is about as terrifying as discovering you're one tortilla short at a taco dinner."

"I heard that!" came the booming voice. The smoke still obscured anything more than an arm's-length away, but Fabian thought he could make out a dim shadow near the ground in front of him. "Article 2, paragraph 5 of my contract clearly states that I am allowed to threaten my summoner!"

"And so you are," Basil said calmly. "By all means, threaten away. It was not my intent to interrupt. Please kindly let us know when you're through."

The smoke was dissipating rapidly on its own now and Fabian was astonished to discover, on the ground about two meters away, a small man with pinkish skin and dark hair, and sporting a narrow goatee much like his own. The little man was dressed in an awkward floral shirt and matching pants, and he stood, in all, no more than knee-high. Arms folded and red eyes glowing fiercely, he was glaring at Basil.

{% include illustration.html align="left" width="400" height="376" image="002-nigel.jpg" alt="Nigel appears" caption='A small man with pinkish skin and a narrow goatee' %}

"Oh, never mind," he said, his deep, grating voice very much at odds with his tiny stature. "You've ruined the moment, as you always do. You're absolutely the *worst* to work for."

Basil smiled. "Fabian, allow me to introduce Nigel."

"'Nigel'?" Fabian asked incredulously.

"'Fabian'?" The demon mimicked, sneering. "'Basil'? Oh, go on." He gestured rudely and turned aside, looking disgusted.

Basil smiled again and leaned in to whisper confidentially to Fabian. "He's a grumpy one, Nigel is, but I've always felt it was just an act. You'll get used to him. He's not even a true demon, really, just a type 2 homunculus, but he gets touchy if you ever try to point that out."

Fabian looked uncomfortably at the tiny man. "So, how is he going to help us?"

Basil gestured at Nigel. "He's a counter--it's one of his specialties. He counts things. He's also a splitter--he can break himself into arbitrarily many copies, each under his control. We'll have him use those attributes with Dijkstra's algorithm to find the shortest path."

"Are you both quite through talking about me?" Nigel asked, still not looking at them. "That's very rude, you realize. I should know. I do it all the time."

Fabian leaned in to whisper to Basil. "Are you sure this is the fastest way? Why couldn't Dijkstra have just made a spell to make you go to the exit?"

Basil shook his head. "No good. I told you Dijkstra was opinionated. He always considered 'go-to' spells harmful." Clearing his throat, he faced the diminutive demon. "All right, Nigel. We need to find our way through that maze, there."

Nigel glanced at it and *tsked*. "Looks complicated. How very sad for you."

“Listen closely, Nigel. Here's what we want you to do:

“*First.* Beginning at the entrance, count the number of steps to the first branching of the path.”

"Typical." Nigel picked distractedly at one of his tiny fingernails.

"*Second.* For each new path at that branch, split yourself."

Nigel sighed in a very put-upon way. "*Sooo* original."

Basil continued, ignoring the little demon's complaints. "Each copy of yourself will then be assigned a different path, and will move down that path, counting steps to the *next* branching. Also, each copy of yourself will always move at the *same pace*. That's important!"

Nigel looked around absently. "Same pace. Got it."

Basil went on. "*Third.* If one of your copies encounters a dead-end, it will stop."

"Oh-ho! He's getting tricky, now, boys."

"And if a copy encounters a path that one of you has already travelled, it will stop, as well."

Nigel yawned, but nodded.

"And *last*, if a copy reaches the exit, it will immediately retrace its steps to the entrance. You may reassemble yourself there. We will then meet you, and you will guide us along the path that last copy took to the exit. At that point, your task will be finished and you may go."

Nigel grimaced. "Oh, come on. Dijkstra's *again*? And not even a very imaginative version of it. Really! At least let me run a greedy algorithm, or an A-star."

"We'll get there, Nigel. I'm training an apprentice."

Nigel eyed Fabian with new interest and stroked his goatee hungrily. "Oh, *really*? How's he doing? Promising?" He grinned viciously at Basil. "Will I finally have an employer worthy of me?"

Basil smiled. "Hope springs eternal, doesn't it?"

Nigel shrugged. "Fine. Get comfortable, then. Dijkstra's isn't exactly the fastest boat in the harbor. Try to enjoy the show." He then trotted down the stairs and into the maze, a subtle red glow springing up around him.

"Here now," Basil said to Fabian, sitting down on the top stair and pointing at the demon. "Watch this."

Fabian followed suit then, and watched.

As Nigel walked into the maze, his red glow seemed to intensify. It clung to the hedges as he passed, lighting the path behind him as if the maze were catching fire. Thus it was that, even though Nigel himself was quickly lost to view, from their vantage at the top of the stairs the two men could easily see the demon as he progressed through the maze.

Fabian watched, entranced, as the red path reached the first intersection. There was the barest of pauses before--true to Basil's instructions--the glow proceeded to follow both paths at the same time.

"See? There he goes," Basil said. "I only wish he could move faster--the effect would be far more dramatic. Alas, it's not in his contract."

Fabian felt the effect was plenty dramatic. It truly was like watching a cascade of water--red water, admittedly--flood the maze. It ran through the passages, filling dead ends and dividing at intersections. The effect spread outward like a wave as Nigel duplicated himself over and over, and each copy did the same. Even at Nigel's unhurried pace, Fabian still quickly lost count of how many copies were active.

"It's...beautiful," Fabian said.

Basil hesitated, and then nodded, looking surprised. "Yes, now you mention it. In fact, I can remember when I first saw this. It fairly dazzled me! Funny how it seems so unremarkable now."

Basil looked troubled as he said it, and sat stroking his mustaches in brow-furrowed silence for a few minutes. Eventually, he shook himself from whatever dark reverie had gripped him.

"Here," he said gruffly. "Let's use the time productively. Hmm." He glanced around before getting up and trotting over to a nearby hedge. Breaking off a small branch, he returned and handed it to Fabian. "Here. You'll want to find a wand of your own, but see if this works at all for now."

Fabian held the branch delicately between thumb and forefinger and cast a doubtful eye upon it. The stick was about as long as his hand, spindly, with one sad leaf clinging stubbornly to the end. "Okay... What do you want me to do with it?"

{% include illustration.html align="right" width="400" height="400" image="002-fabian-and-his-stick.jpg" alt="Fabian and his stick" caption='"What do you want me to do with it?"' %}

Basil gestured to the maze, which was slowly filling up with red. "Sketch a map. Make an illusion. Just picture it in your head, and when you start sketching, *believe*."

Fabian sighed. "'Believe'. Just like that?"

"Just like that."

Fabian nodded, took a deep breath, and after the barest hesitation, started sketching.

Nothing happened.

"Try again," Basil instructed.

Fabian tried again, to no effect. He tried again and again, for many long minutes, before Basil finally snatched the makeshift wand away and eyed it. Holding it in his own hand, he made a few broad strokes, each of which blossomed in the air into splashes of color. Basil gestured, and the colors faded away.

"It definitely isn't the wand," Basil said. He eyed Fabian for a moment before handing the twig back to him. "For now, I guess I can only suggest you keep practicing. Some people grasp the illusion spell right away. Others have to come to it in their own time. I suspect you may be one of the latter."

"Lucky me," Fabian sighed. He took the twig and tucked it into his pocket.

They watched in silence for several minutes more before the red glow finally reached the exit, at which point all the red drained from the maze. The red glow at the exit began moving back toward the entrance, keeping to the same deliberate pace. Eventually it reached the first passage, and they could see Nigel again. He looked *faded* somehow, but as he reached the entrance, he paused and quite suddenly grew solid again. Fabian realized the demon had re-assimilated his many copies.

"Well, there he is," Basil said, rising and dusting himself off. "Let's go see which path he's going to recommend."

The two walked down the steps and met Nigel at the bottom. The demon made an exaggerated bow. "Two thousand, eight hundred and fifteen," he said.

Fabian raised an eyebrow, but Basil explained. "The number of steps he took to the exit," he said. "Remember? I told him to keep track."

"Ah," Fabian said, remembering.

Basil turned back to the demon and gestured toward the entrance. "Lead on!"

Nigel rolled his eyes, but turned back around and reentered the maze. The two men followed him.

Though the red glow had disappeared, Nigel seemed to be quite confident in the route to take, turning without hesitation at some intersections and proceeding boldly past others. So it was that they soon reached the exit and found Curmudgeon Castle looming (or perhaps *trying* to loom--it wasn't very large, or particularly imposing) just beyond.

Nigel sniffed. "There you are, good sirs. If there's anything else you need, please call someone else." Before they could reply, he disappeared in a puff of brimstone-scented smoke.

Basil dusted his hands off. "Well, that's that. Come along, we'll have to review the lesson later. It looks like someone's waiting for us, there." He strode out of the maze.

A dozen meters outside stood a portly, bespectacled man dressed in a plaid kilt and wearing a rather garishly-colored Tam o' Shanter on his head. He was leaning casually on a long staff some three or four hands taller than himself, gnarled and knobbly as if it had been taken directly from some unfortunate tree.

{% include illustration.html align="left" width="400" height="400" image="002-fergus-curmudgeon.jpg" alt="Fergus Curmudgeon" caption='A portly, bespectacled man dressed in a kilt...' %}

"Fergus!" Basil hailed him. "Fergus Curmudgeon. It's been a long time!"

Fergus nodded carefully. "Aye," he said, frowning. "Indeed it has, Basil Smockwhitener. We've managed to scrape together a room for you, but you said to expect a manservant, too. Did we make those preparations for nothing, then?"

Basil looked around in startlement, realizing now that Fabian was nowhere to be seen. "Well, I'll be. Where did that fellow hide himself?" He suddenly saw him then, hiding in the shadows of the maze, and gestured sharply. "Fabian!" he said. "Get out here! What are you doing?"

Fergus started visibly at mention of Fabian's name, and started again--even more violently--when Fabian himself emerged from the maze. He lowered his staff and pointed it at the manservant. "*You!*" he said, his voice venomously low and intense.

Fabian waved weakly, smiling like he was going to be ill. "'Lo, Fergus."

Basil looked confused. "Wait, you two *know* each other?"

"*Know* him?" Fergus spat to one side. "Of course I know him! He's my wretched, good-for-nothing, no-account brother, is all!"
