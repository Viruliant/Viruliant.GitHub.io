Copyright © 2014 Roy Pfund                                 All rights reserved.
Use of this software and associated documentation  files  (the  "Software"), is
governed by a MIT-style License(the "License") that can be found in the LICENSE
file. You should have received a copy of the License along with this  Software.
If not, see http://Viruliant.googlecode.com/git/LICENSE.txt

In addition to being Meta-Circular Viruliant is to provide the abilities seen in
[Ben Swift Debugging AND Recompiling the currently running application](http://vimeo.com/99891379).
[Sorensons Acoustic DUAL Piano Scheme Setup Video(NOT in Stereo)](http://youtu.be/yY1FSsUV-8c?t=140s) may serve as a more layman's description of what this might look like, or at least how it should sound.
It is supposed to do this, using an Earley Parser similar to the one descibed by
[Keshav](http://youtu.be/eeZ3URxd8Wc). All in the spirit of 

With [N1256](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf) as its target, but in the style of 
[/Cite/mkconfExample](Cite/mkconfExample)

Eventually all instances of and/or/not english boolean and set  logic  notations
will be replaced with the following language agnostic symbols.

|α↓β|α⇐β|α⇒β|α⇑β|---|Operator               |---|Negation             |
|---|---|---|---|---|-----------------------|---|---------------------|
|1  |0  |0  |0  |α↓β|Joint denial           |α⇓β|Disjunction          |
|0  |1  |0  |0  |α⇐β|Converse Nonimplication|α←β|Converse Implication |
|0  |0  |1  |0  |α⇒β|Nonimplication         |α→β|Implication          |
|0  |0  |0  |1  |α⇑β|Conjuction             |α↑β|Alternative denial   |
|0  |0  |1  |1  |α  |Proposition α          |¬α |Negation α           |
|0  |1  |0  |1  |β  |Proposition β          |¬β |Negation β           |
|1  |0  |0  |1  |α↔β|Biconditional          |α⇔β|Exclusive Disjunction|
|1  |1  |1  |1  |⊤  |Tautology              |⊥  |Contradiction        |

|---|Venn Diagram|---|
|---|------------|---|
|α↓β|![](venn.svg?JointDenial=#666&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#FFF)|α⇓β|
|α⇐β|![](venn.svg?JointDenial=#FFF&ConverseNonimplication=#666&Nonimplication=#FFF&Conjuction=#FFF)|α←β|
|α⇒β|![](venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#666&Conjuction=#FFF)|α→β|
|α⇑β|![](venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#666)|α↑β|
|α↔β|![](venn.svg?JointDenial=#666&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#666)|α⇔β|
|α  |![](venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#666&Conjuction=#666)|¬α |
|β  |![](venn.svg?JointDenial=#FFF&ConverseNonimplication=#666&Nonimplication=#FFF&Conjuction=#666)|¬β |
|⊤  |![](venn.svg?JointDenial=#666&ConverseNonimplication=#666&Nonimplication=#666&Conjuction=#666)|⊥  |



[dlopen_self.c](Cite/mkconfExample/dlopen_self.c)-
Shows how to use dlsym to examine the running executable's properties. This lets
you, e.g., look up one of your own global variables by its string *name*,  which
is pretty amazing.

[dlopen_gcc.c](Cite/mkconfExample/dlopen_gcc.c)-
Shows how to write some code at runtime, compile the code into a shared library,
link in the new shared library, and use its new functions.

[dlopen_libc.c](Cite/mkconfExample/dlopen_libc.c)-
Shows how to use dlopen to examine a shared libraries' symbols and functions. In
this case, we look up and call the math  library's  "cos"  routine.  (Just  like
Linux' man dlopen).

This project MIGHT depend on the following wonderful software:
--------------------------------------------------------------
* https://github.com/cheusov/mk-configure
* bmake
