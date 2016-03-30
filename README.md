Copyright © 2014-2015 Roy Pfund             All rights reserved.

Use of this software and  associated  documentation  files  (the
"Software"), is governed by a MIT-style  License(the  "License")
that can be found in the LICENSE file. You should have  received
a copy of the License along with this Software. If not, see

    http://Viruliant.Github.io/LICENSE-1.0.txt
________________________________________________________________

#VIR·U·L·IANT
##ˈvir(y)əlyənt/
> Hostly possessing courage & determination; extremely severe in its effects.
___

[Sorenson's Acoustic DUAL Piano Scheme Setup Video(NOT in Stereo)](http://youtu.be/yY1FSsUV-8c?t=140s)
shall serve as a layman's description of what a live Scheme interpreter/translator/compiler can look like;
It is also an Excellent Musical Piece, w/Narration of how his code generates it(you may also wish to rewind it to the begining, to hear more details).

In the spirit of:

 * ["falling out for free" --1986SICPLec4](http://youtu.be/h6Z7vx9iUB8?t=1h17m33s)
 * ["how to have our cake in functional style and eat it too"(limited by a dragging tail) --1986SICPLec6](https://youtu.be/a2Qt9uxhNSM?t=46m7s)
 * ["using logic to express what is true, you use logic to check whether something is true, and you use logic to find out what is true." --1986SICPLec8](https://youtu.be/cyVXjnFL2Ps?t=18m)
 * [Ben Swift Debugging AND Recompiling the currently running application.](http://vimeo.com/99891379)

Viruliant is to provide a [Subset](/Cite/R5RS/R5RS-Language) of the [R5RS Scheme Languge](/Cite/R5RS/R5RS Specification.pdf) by either direct lambda calculus, interpreting, or translating to [C99](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf) in a similar fashion as how OOP has been added to C99 in
[Object-oriented design patterns in the kernel, part 1](http://lwn.net/Articles/444910/) and [part 2](http://lwn.net/Articles/446317/).
[AntiThread](https://github.com/rustyrussell/ccan/tree/master/ccan/antithread), &
[mkconfExample](Cite/mkconfExample).

###Ways You Can Participate
* **Share** [the Website](https://Viruliant.GitHub.io)
* **Chat** @ [![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Viruliant/Viruliant.GitHub.io?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
* **View** [the Code](https://github.com/Viruliant/Viruliant.GitHub.io)
* **Solve** [Issues from the Issue Tracker](https://github.com/Viruliant/Viruliant.GitHub.io/issues),
* **Submit** a [New Issue](https://github.com/Viruliant/Viruliant.GitHub.io/issues/new) if you do not see it listed there.
* **Donate** via [Bitcoin]() or [Paypal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=adamantapparition%40gmail%2ecom&lc=US&no_note=0&cn=Add%20a%20note%20to%20the%20Donation%3a&no_shipping=1&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted),
If you like this project and/or want to see more projects like it.

____________________
##Agnostic Semantics

BOTH Viruliant and NTL WILL Use the following Language Agnostic Grammar, Boolean, & Set Logic Operands

|α↓β|α⇐β|α⇒β|α⇑β|---|Operator |---|Negation |
|---|---|---|---|---|-----------------------|---|---------------------|
|1 |0 |0 |0 |α↓β|Joint denial |α⇓β|Disjunction |
|0 |1 |0 |0 |α⇐β|Converse Nonimplication|α←β|Converse Implication |
|0 |0 |1 |0 |α⇒β|Nonimplication |α→β|Implication |
|0 |0 |0 |1 |α⇑β|Conjuction |α↑β|Alternative denial |
|0 |0 |1 |1 |α |Proposition α |¬α |Negation α |
|0 |1 |0 |1 |β |Proposition β |¬β |Negation β |
|1 |0 |0 |1 |α↔β|Biconditional |α⇔β|Exclusive Disjunction|
|1 |1 |1 |1 |⊤ |Tautology |⊥ |Contradiction |

____________________________________
#NTL: Numerical Translation Language

###All Translation SHALL:
 * attempt create a notation to put into comments in the generated code
   such that the process can be reversed.

 * Use an Earley Parser similar to [Keshav](http://youtu.be/eeZ3URxd8Wc).
also used in the Grammar Spec the parser uses
 ⊤↔ 
 ⇓ 

 * "The TXL paradigm consists of parsing the input text into a structure tree,
   transforming the tree to create a new structure tree, and unparsing the new tree
   to a new output text" NTL will do the same


mkconfExample
-------------
[dlopen_self.c](Cite/mkconfExample/dlopen_self.c)-
Shows how to use dlsym to examine the running executable's properties. This lets
you, e.g., look up one of your own global variables by its string *name*, which
is pretty amazing.

[dlopen_gcc.c](Cite/mkconfExample/dlopen_gcc.c)-
Shows how to write some code at runtime, compile the code into a shared library,
link in the new shared library, and use its new functions.

[dlopen_libc.c](Cite/mkconfExample/dlopen_libc.c)-
Shows how to use dlopen to examine a shared libraries' symbols and functions. In
this case, we look up and call the math library's "cos" routine. (Just like
Linux' man dlopen).

This project MIGHT depend on the following wonderful software:
--------------------------------------------------------------
* http://llvm.org/git/llvm
* http://llvm.org/git/clang
* http://github.com/santoshn/softboundcets-34.git
* https://github.com/rustyrussell/ccan/tree/master/ccan/antithread
* https://github.com/cheusov/mk-configure
* bmake

_______________
##Venn Diagrams

|---|Venn Diagram|---|
|---|------------|---|
|α↓β|<object type="image/svg+xml" data="venn.svg?JointDenial=#666&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#FFF"></object>|α⇓β|
|α⇐β|<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#666&Nonimplication=#FFF&Conjuction=#FFF"></object>|α←β|
|α⇒β|<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#666&Conjuction=#FFF"></object>|α→β|
|α⇑β|<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#666"></object>|α↑β|
|α↔β|<object type="image/svg+xml" data="venn.svg?JointDenial=#666&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#666"></object>|α⇔β|
|α |<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#666&Conjuction=#666"></object>|¬α |
|β |<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#666&Nonimplication=#FFF&Conjuction=#666"></object>|¬β |
|⊤ |<object type="image/svg+xml" data="venn.svg?JointDenial=#666&ConverseNonimplication=#666&Nonimplication=#666&Conjuction=#666"></object>|⊥ |

