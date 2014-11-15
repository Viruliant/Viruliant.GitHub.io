/* Orion Lawlor's Short UNIX Examples, olawlor@acm.org 2003/8/18

Shows how to write some code at runtime, compile
the code into a shared library, link in the new shared library, 
and use its new functions.

This makes C++ feel more like an interpreted language.
And it's fast!  It only takes 70ms to compile, link, and run!
*/
#include <stdio.h>
#include <dlfcn.h> /* for "dlopen" */
#include <stdlib.h> /* for "system" */

int some_symbol;

int main() {
	/* Write some code at runtime */
	FILE *code=fopen("code.c","w");
	fprintf(code,"#include <stdio.h>\n"
"void funkyfunc(void) {printf(\"Hello, World!\\n\");}\n");
	fclose(code);
	
	/* Compile the new code */
	system("gcc -shared code.c -o code.so; rm code.c");
	
	{ /* Open the freshly-compiled shared library and run it */
		void *lib=dlopen("./code.so",RTLD_LAZY);
		typedef void (*void_fn_t)(void);
		void_fn_t func=(void_fn_t)dlsym(lib,"funkyfunc");
		func();
	}
	return 0;
}

/*<@>
<@> ******** Program output: ********
<@> /usr/bin/ld: /tmp/ccSzslMt.o: relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
<@> /tmp/ccSzslMt.o: could not read symbols: Bad value
<@> collect2: ld returned 1 exit status
<@> */
