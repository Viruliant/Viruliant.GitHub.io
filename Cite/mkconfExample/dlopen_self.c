/* Orion Lawlor's Short UNIX Examples, olawlor@acm.org 2003/8/18

Shows how to use dlsym to examine the running executable's
properties.  This lets you, e.g., look up one of your own
global variables by its string *name*, which is pretty amazing.

Note that this only works if the executable
is compiled with "-fpic" (so some_symbol shows up in the
run) as well as linked with "-ldl" (at least under Linux).
*/
#include <stdio.h>
#include <dlfcn.h>

int some_symbol;

int main() {
	void *sptr=dlsym(NULL,"some_symbol");
	printf(" Symbol is really at %p;\n",&some_symbol);
	printf(" dlsym shows it at %p\n",sptr);
	return 0;
}
/*<@>
<@> ******** Program output: ********
<@>  Symbol is really at 0x600b0c;
<@>  dlsym shows it at 0x600b0c
<@> */
