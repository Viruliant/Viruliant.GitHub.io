Copyright © 2014-2015 Roy Pfund             All rights reserved.

Use of this software and  associated  documentation  files  (the
"Software"), is governed by a MIT-style  License(the  "License")
that can be found in the LICENSE file. You should have  received
a copy of the License along with this Software. If not, see

    http://Viruliant.Github.io/LICENSE-1.0.txt

Viruliant
---------
Viruliant aims to be an SharedLibrary/Executable made to translate from a
[Subset of R5RS](/Cite/R5RS/R5RS-Language) to [C99](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf)"
in a similar fashion, to how OOP has been added to C99 in
[Object-oriented design patterns in the kernel, part 1](http://lwn.net/Articles/444910/)
and [part 2](http://lwn.net/Articles/446317/).

Viruliant is also to provide the abilities seen in [Ben Swift Debugging AND
Recompiling the currently running application](http://vimeo.com/99891379).
[AntiThread](https://github.com/rustyrussell/ccan/tree/master/ccan/antithread) &
[mkconfExample](Cite/mkconfExample) will serve as quotes & libs of part of how
generated code will appear.

All of Viruliant is to be in the spirit of [falling out for free(after you've
waded through muck)](http://youtu.be/h6Z7vx9iUB8?t=1h17m33s).

Ways You Can Help
-----------------
* Help me solve [Issues from the Issue Tracker]().
* "[Submit A New Issue]()".
* If you like this project and/or want to see more projects like it:
  Please Donate via [Bitcoin]() or [Paypal]().

More Information
----------------
[Sorenson's Acoustic DUAL Piano Scheme Setup Video(NOT in Stereo)](http://youtu.be/yY1FSsUV-8c?t=140s)
shall serve as a more layman's description of what a live Scheme interpreter or
compiler can look like; It is also an Excellent Musical Piece, w/Narration of
how his code generates it.

This page is just a readme, for more information about actually using Viruliant
please consult [The Wiki](): 

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

