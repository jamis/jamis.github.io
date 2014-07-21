---
layout: post
title: Counting the Cost
chapter: Chapter 7
words: 3131
blurb: >
  Wherein Fabian learns how to color, and how to count. Later, a chance
  encounter leads him somewhere wholly unexpected.
previous_chapter: /2014/07/08/following-a-star
next_chapter: /2014/07/20/thats-cows-for-you
scripts:
  - /js/colors-minified.js
script: |
  window.onload = function() { generateColors("colors-canvas", 70); };
---

Fabian sat opposite Nigel in the small cell. It was morning, apparently. No sunlight could reach the dungeons, but breakfast had been delivered, a meager bowl of gruel that sat still-untouched on the floor by the door.

{% include illustration.html align="right" width="400" height="400" image="007-morose.jpg" alt="Sad Fabian" caption='Fabian sat opposite Nigel in the cell' %}

A guard had interrupted their conversation the day before, arriving to announce through the barred window that two guards were being posted at either end of the hall. They wanted to make sure he did not attempt any further escapes. Nigel, startled, had disappeared in a puff, and Fabian had been so despondent at the news that he hadn't bothered to re-summon the homunculus. He'd simply gone to bed.

The next morning, though, Nigel had been there in the cell. He didn't say anything, and Fabian was still so disheartened by the additional guards that he couldn't bring himself to ask him any questions. Nigel didn't seem to mind being ignored, though. He was sitting beside the wall, doodling cheerfully in the grime on the floor. *Too* cheerfully. Fabian wanted to throw something at him.

A sudden flash of light and color startled Fabian, and he realized it had come from Nigel's doodle. He looked over in time to see him rubbing out his drawing and starting again.

He started paying attention, watching as Nigel sketched, and realized he was drawing a *maze*. It was a complex one, large, with many passages. The homunculus hesitated a moment when he noticed Fabian watching, and grinned. With a tap, he somehow made the drawing blossom into vibrant shades of red and purple. It actually glowed a moment in the gloom before fading away, like an afterimage from glancing at the sun. Nigel rubbed it out and began drawing another one.

"What are you doing?" Fabian finally asked.

Nigel shrugged casually. "Coloring."

Fabian considered that answer, and decided he needed more. "How?"

"Magic."

Fabian sighed. "I can *see* that."

"Good. Going blind just now would be a bit of an inconvenience, you know. These things are no good without an audience."

There was silence as Nigel fleshed out this next maze, adding corridors and dead-ends. Fabian finally spoke again. "What I meant was, how are you making those patterns I saw? All you have right now are lines drawn in the dirt."

It was obvious there was a pattern of some sort. When Nigel tapped the maze this time, color seemed to fill it outward from where he'd tapped it, running down the passages in scintillating waves and growing darker as it reached the edges. The result was a stunning splash of green that could almost be a window into some forest.

When the color faded away, Nigel sat back and eyed Fabian. "You really want to know."

"Sure," Fabian said, sitting back himself and gesturing to the walls of his cell. "Looks like I may be here awhile."

Nigel pointed at what he'd sketched. With the colors gone, it was just a line drawing of a maze again. "It's pretty straightforward, really. I'm just picking a point inside the maze to start from, and running Dijkstra's algorithm from there. That will tell me how far each point in the maze is from that starting point, right?"

Fabian nodded.

"So once I know how far away each point is, I just color them all based on their distance from that point. The further away they are, the darker color."

"Huh." Fabian considered that. "Show me again."

Nigel sighed. "Watch."

He rubbed out the first drawing and drew another good-sized maze on the floor, passages winding around. Dead-ends were scarce, and Fabian realized there were no loops. A *perfect* maze. He asked Nigel about it.

"Oh, it works fine with multiply-connected mazes, too," he answered as he sketched. "But the perfect mazes tend to produce more interesting pictures." He finished and tapped it, and it flashed briefly to light in shades of yellow. The impression was of some brilliant flower, blossoming in the dimness.

Fabian nodded appreciatively. "Do another one!"

{% include demo/colors.html link="Don't let Nigel have all the fun! Come play with an interactive demo, where you can tap and watch mazes flood with color. See what designs are hidden in the passages and dead-ends." %}

Nigel obliged, and in fact wound up making several more. Fabian was entranced. "This is some great art," he said when Nigel was finished.

Nigel seemed uncomfortable with the compliment. "Oh, it's just...just mazes, you know. Something to pass the time. Nothing, really..." He found a bit of straw on the floor and started twirling it between his fingers, gazing at nothing in particular.

They lapsed back into silence, but something about the colored mazes had snapped Fabian out of his slump. He was thinking again, even considering the possibility of escape. And with the thought of escape came the memory of what he and Nigel had been discussing the day before.

"So, Nigel," he said. "Yesterday you started telling me the question I *ought* to have asked. Something about cost?"

Nigel nodded a few times, thinking. "All right," he said after a moment. "Cost, then." He dropped the piece of straw and sat up, looking Fabian in the eye. "Tell me: what were the biggest problems with the route I chose last time?"

Fabian shrugged and leaned back against the wall. "Easy. First, you took me to a secret door that I had to figure out how to open, which wasted time. Then our path led right through the sparring room for the castle guards. Hardly what I'd call an effective escape route."

Nigel nodded. "As you say. In my defense, I was doing only---and exactly---what I'd been instructed to do."

"We've been over this."

"Yes. Repeatedly. Would you like to hash it out one more time?"

Fabian sighed and shook his head. "No. Go on."

"Gladly. So, we might say the path we took was *expensive*. Parts of it, at any rate. Other parts were actually pretty cheap."

"Like that shortcut through the storage rooms."

"Precisely. So, our path had *expensive* parts, and it had *inexpensive* parts."

Fabian nodded thoughtfully. "I see where you're going. You're saying that I should have been asking for the path to have only inexpensive parts."

Nigel nodded. "There you go. You want the overall cost of the path to be as low as possible. Often, a short path *is* an inexpensive path, but sometimes there may be obstacles or barriers that can greatly increase the cost of those paths."

Fabian sighed. "So, what? Do I need to learn a new algorithm for this? I don't know how much more I can hold in my head just now." He rubbed his temples tiredly.

Nigel snorted. "Don't you worry that tightly-packed little brain of yours." He paused in mock horror. "Oh, my! Did I say 'little'? I'm so sorry! I meant '*really* little.'" He snickered.

Fabian shook his head drily. "Hilarious."

"Spoilsport. Anyway. No, you don't need to learn any new algorithm. Dijkstra's, greedy, A\*---those can all still be used. You just need to substitute cost for distance."

"'Just,' he says. It's really as easy as using some cost instead of distance?"

"Well, no, but almost. Consider this scenario." Nigel drew a picture of a graph in the dirt on the floor.

{% include figure.html width="300" height="300" image="007-graph-01.jpg" alt="A simple graph" %}

"If I were to start here"---he tapped a vertex---"and run Dijkstra's, what would happen?"

{% include figure.html width="300" height="300" image="007-graph-02.jpg" alt="A simple graph, with start and finish labelled" %}

Fabian scooted over to getter a better look. He pointed at the vertices adjacent to the starting node. "First, you'd walk to those, and then to those next to them."

{% include figure.html width="300" height="300" image="007-graph-03.jpg" alt="Fabian's answer" %}

Nigel nodded. "Right. So the shortest distance from the start, to here"---he tapped the top node---"would be two, right?"

"Right."

"Good. Now, I'm going to write some numbers by the edges, here, to represent how expensive it is to travel on each edge. We'll make them all the same, to start." He wrote "1" in the dirt next to each edge. 

{% include figure.html width="300" height="300" image="007-graph-04.jpg" alt="Simple weights" %}

&ldquo;Okay. Now, we're going to sum the cost of the edges as we go, instead of just counting steps. At the beginning, the cost is zero, since we haven't gone anywhere yet. I'll just write a zero there.

{% include figure.html width="300" height="300" image="007-graph-05.jpg" alt="Starting counting" %}

&ldquo;Now, just as before, we clone ourselves and skip along to the neighboring vertices. We write the *total cost* of making that trip next to each node.

{% include figure.html width="300" height="300" image="007-graph-06.jpg" alt="More counting" %}

&ldquo;We do that again, noting the *total cost so far*.

{% include figure.html width="300" height="300" image="007-graph-07.jpg" alt="Done counting" %}

"One more time, and we see that the cost to reach that last node is more than the cost we've already recorded there, so we stop---we can't possibly improve on that score. So we're done!"

Fabian considered it. "That's the same answer as before, though, when we did it without the costs."

Nigel gasped in faux surprise. "You spotted it! My goodness. And I only had to *almost* hand it to you."

Fabian gave Nigel a level stare. The homunculus shrugged. "Anyway, yes, it was the same result. That's because we weren't actually doing it *without* costs before. We were just doing it with the *same* cost for each edge, implicitly."

"All right. So, what happens when the costs *aren't* the same?"

"*Now* you're asking some good questions." Nigel grinned, and then rubbed out the numbers next to each edge. "Let's try it, and see!"

He wrote down different numbers this time, and started the process again.

{% include figure.html width="300" height="300" image="007-graph-08.jpg" alt="Different weights" %}

&ldquo;So, as before, we start with a cost of 0. Then we move to the adjacent nodes, and add the cost of their corresponding edges.

{% include figure.html width="300" height="300" image="007-graph-09.jpg" alt="Counting again" %}

&ldquo;Then, again, we move to *those* adjacent nodes, and add the cost of *their* corresponding edges.

{% include figure.html width="300" height="300" image="007-graph-10.jpg" alt="Counting again, continued" %}

&ldquo;We do this all the way to the end, only *this* time, look what happens when that path on the right reaches the top.

{% include figure.html width="300" height="300" image="007-graph-11.jpg" alt="Counting again, continued" %}

"The cost it has for the path is less than what was already recorded, so we replace the previous cost with the new cost. If we try to go one more step, we find that our proposed cost is more than what was already recorded there, so we stop."

{% include figure.html width="300" height="300" image="007-graph-12.jpg" alt="Best path!" %}

Fabian cocked his head. "So the shortest path is actually the longest?"

Nigel barked a laugh. "In a sense, I guess! But it's not the shortest path anymore---it's the *least expensive* path. In this case, the *best* path is also the *longest* path, because the shortest path was more expensive."

Fabian nodded. "And that works for all three of those algorithms?"

"Absolutely," Nigel agreed. "Because all three are variations of each other, right?"

Fabian sat in silence for a few moments. "Well," he finally said, "I guess all that's left is to figure a way out---"

He was interrupted by a sudden crashing sound in the hallway---metal-on-stone, it seemed---and paused to listen.

Silence.

Fabian shrugged. "Anyway," he continued, "I was saying, all that's left is to figure---"

There was a *click*, and the hinges squealed as the door swung slightly open.

"Ummm..." Fabian looked blankly at the door.

Nigel sighed. "You were saying?"

"Right," Fabian said, getting up. "That was...convenient." He moved quietly to the door and peeked out the barred window, but could see nothing there. Wincing at the noisy hinges, he pushed the door open wider and looked up and down the hall.

A guard lay in an untidy heap at either end. One groaned briefly, but remained still. No one else could be seen.

{% include illustration.html align="left" width="400" height="400" image="007-guards.jpg" alt="The way out" caption='No one else could be seen' %}

"Ummm..." Fabian said again.

"Timid today, I see." Nigel was standing to the side, tapping one foot impatiently.

"No," Fabian said, craning his neck to see into the hall. "It's just...well, I don't see anyone around, so...it must have been magic. I'd suspect Basil, but those guards...Basil would *never* harm someone with magic like that."

Nigel snorted. "Right. Poor guards. But what about the demon who has to come when called, even if said demon happens to be in the middle of donning a freshly laundered pair of his favorite pants, and thus appears *en dishabille* before mixed company?"

Fabian turned to look down at the homunculus. "Seriously? That happened?"

Nigel blushed. "Just...hypothetically."

Fabian raised his eyebrows. "Right. Anyway, *someone* must be on our side. Come on, it looks like you get to show me just how well the cost-counting works with A\*."

* * *

They made good time. Surprisingly, Nigel found a third exit from the dungeons, another small servants' stair that came out just behind the kitchens. It was a little farther away than the other servants' stair, but Fabian assumed this one was selected because it had no squeaky door, which presumably lowered its cost.

They were in familiar territory again. As a child he'd made many trips to the kitchens, pilfering bits of whatever was baking (usually meatloaf) and then racing back to his rooms. He knew of three exits that were nearby, and was heartened to see that Nigel appeared to be making for one of the least-used of those. They were close.

As they drew nearer, though, the sound of voices and footsteps came murmuring around a corner ahead of them, and they quickly ducked into an alcove. The voices grew louder, and Fabian realized with a jolt that he recognized them.

"...but from a construction perspective, the [recursive division algorithm](http://weblog.jamisbuck.org/2011/1/12/maze-generation-recursive-division-algorithm) would seem ideal---"

"You say that only because it works by building walls, instead of tunneling."

"Well, of course, so why not prefer it over the others?"

"Because of that bias! My boy, you have a lot to learn if you're going to be building mazes anytime soon. You need to remember that any maze can be converted into a wall-oriented blueprint after the fact---"

Fabian was torn. The voices were clearly Monsanto and Basil. Should he reveal himself? He wondered if it was Basil who facilitated the escape in the first place. If it was, perhaps Basil was hoping Fabian would make his way clear in silence. But if it wasn't... Fergus would never throw Fabian in a dungeon cell just to immediately turn around and sneak him free, so there must be *another* wizard in the castle. Basil would like to know that.

The two were moving abreast of the alcove, deep in their conversation. Fabian made up his mind, stepping out into the hall just as the pair came by. They looked up in surprise.

{% include illustration.html align="right" width="400" height="400" image="007-basil-monsanto.jpg" alt="Fabian reveals himself" caption='They looked up in surprise' %}

"Fabian?" Basil seemed shocked to see him there, his mustaches quivering in an absurd mirror of his own surprise. "How did you---" He glanced at Monsanto. "I mean, ah, they released you, did they?"

Fabian realized by the look on his master's face that Basil wasn't behind his escape. He had mixed emotions at the revelation. "In a sense, sir," he said. "Though we should probably not tell Fergus about it."

Basil shook his head in confusion, but shrugged. "I should go get my things. I can meet you outside the castle in a few minutes." He glanced at Monsanto. "But..."

Fabian smiled. "Don't worry about Monsanto, sir," he said. "He and I are old friends."

Monsanto nodded. "You have my solemn oath, sir, that I won't give Fabian up to his brother. In fact, I'll go with him, to make sure he gets to the servants' exit."

"As you say, then. I'll meet you outside." Basil hurried off down the hall.

Fabian watched his master go and then glanced around, looking for Nigel. The homunculus had, once again, disappeared.

"Is everything okay?" Monsanto asked, looking around as if to see what Fabian was trying to find.

Fabian nodded absently. "Yeah," he said, still looking around. "I was just looking for...ah...my friend."

Monsanto's eyebrows climbed slowly up his forehead. "Right..." he said. "How about you just come with me? Everything's going to be okay."

Fabian shrugged. "Sure. Let's go." He grinned at Monsanto. "And thanks again. It's just like old times, eh?"

Monsanto smiled back. "Just like old times."

* * *

They were nearly to the exit, now. Fabian could see it---an unremarkable wooden door on the right side of the passage just ahead of them. Across from it was one of the castle's ubiquitous stairwells climbing up to the residential areas, and used primarily by servants involved with cleaning and maintenance. Fabian had used these stairs and halls often as a kid, mostly when running down them to find a place to hide after performing some prank or another.

Monsanto had been silent during the few minutes they'd been walking together, and Fabian saw no reason to intrude on his reveries. He was frankly a bit occupied with escaping at the moment, anyway, and was grateful his old friend wasn't in a talkative mood.

Without warning, a scream slammed into him, shattering Fabian's focus into millions of gibbering pieces. He spun around, searching for the source as the sound reluctantly faded. Monsanto pointed to the stairs. "There!"

They ran to the stairwell and peered up, listening.

"Who was that?" Fabian asked. "One of the servants, maybe?"

Monsanto shook his head. "I'm not sure."

They listened a moment more, but heard only silence. Fabian eventually turned away from the stairs and leaned against the wall, breathing heavily. His hands were shaking. "Maybe one of the maids dropped something. Or got startled." He wiped his forehead and straightened. "Anyway, they've stopped now. Let's---"

The scream sounded again, frantic, terrified. "Help! Help! Help!"

Fabian hesitated. "Who---?"

Monsanto shook his head, peering up the stairs as the screams continued. "I don't know. It's not a voice I recognize. We---" He looked at Fabian, and then glanced quickly at the door. He shrugged helplessly. "I'm sorry, Fabian. We have to help her. You know we do."

Fabian looked longingly at the door, but nodded. "You're right."

They raced up the stairs, taking them two at a time, following the screams and coming out on the third floor. A door was open, leading to one of the suites. It was clearly the source of the sound.

Fabian didn't hesitate. He charged through the door, Monsanto close behind, and immediately stopped in surprise.

The room was chaotic, full of easels, buckets, brushes, and half-finished stone sculptures. Paintings hung on the walls, harsh monochromatic treatments of mazes that seemed all sharp angles and edges, though a particularly vibrant portrait of Fergus offered startling contrast.

{% include illustration.html align="left" width="400" height="374" image="007-chaos.jpg" alt="Chaotic studio" caption='The room was chaotic' %}

The screams had stopped.

He heard the door behind him close, and he spun around to find Monsanto removing a key from the lock. "What are you doing?" he asked, confused.

"Following orders," Monsanto said. "I'm sorry, old friend."

Before Fabian could fully process Monsanto's meaning, another voice spoke. A woman's voice, shockingly familiar and startlingly out of place.

"Hello, Fabian."

Fabian spun back around, searching through the easels and buckets and tools for the source of the voice. There she was. A slightly-built woman seated amid the supplies, dressed in a paint-spattered grey smock. Her eyes were hard and angry, but he recognized her. He could never forget her.

"*Anathema?!*"
