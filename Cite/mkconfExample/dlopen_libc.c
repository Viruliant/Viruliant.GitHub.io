/* Orion Lawlor's Short UNIX Examples, olawlor@acm.org 2003/8/18

Shows how to use dlopen to examine a shared libraries'
symbols and functions.  In this case, we look up and
call the math library's "cos" routine. (Just like 
Linux' man dlopen).
*/
#include <stdio.h>
#include <dlfcn.h>

typedef double (*cos_fn_t)(double);
int main() {
	void *libm=dlopen("libm.so",RTLD_LAZY);
	cos_fn_t cos_fn=(cos_fn_t)dlsym(libm,"cos");
	double arg=0.0;
	double result=(cos_fn)(arg);
	printf(" dynamically loaded cosine of %f is %f\n"
		" cosine is at %p, libm handle is %p\n",
		arg,result, (void *)cos_fn,libm);
	dlclose(libm);
	return 0;
}
/*<@>
<@> ******** Program output: ********
<@>  dynamically loaded cosine of 0.000000 is 1.000000
<@>  cosine is at 0x2acf03da33d0, libm handle is 0x2acf034608a0
<@> */
