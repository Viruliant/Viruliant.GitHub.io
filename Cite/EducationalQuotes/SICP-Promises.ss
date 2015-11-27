#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;    Use of this software and  associated  documentation  files  (the
;    "Software"), is governed by the Creative Commons  Public  Domain
;    License(the "License"). You may obtain a copy of the License at:
;        https://creativecommons.org/licenses/publicdomain/
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/gYF0pW SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(load "SICP.ss")
;_______________________________________________________________________Promises
;The R5RS Spec lists the following as a possible implementation of force & delay
(define make-promise
	(lambda (proc)
		(let ((result-ready? #f)
				(result #f))
			(lambda ()
				(if result-ready?
					result
					(let ((x (proc)))
						(if result-ready?
							result
							(begin (set! result-ready? #t)
								(set! result x)
								result))))))))

;________________________________________________________________(force promise)
; Forces the value of promise. If no value has been computed  for  the  promise,
; then a value is computed and returned. The value of the promise is cached  (or
; “memoized”) so that if it is forced a second time, the previously computed
; value is returned.
(define force (lambda (object) (object)))

;_____________________________________________________________(delay expression)
; The delay construct is used together with the  procedure  force  to  implement
; lazy evaluation or call by need. (delay expression ) returns an object  called
; a promise which at some point in  the  future  may  be  asked  (by  the  force
; procedure) to evaluate expression ,  and  deliver  the  resulting  value.  The
; effect of expression returning multiple values is unspecified.
(define-syntax delay
	(syntax-rules () ((delay expression) (make-promise (lambda () expression)))))



;________________________________________(eval expression environment-specifier)
; Evaluates expression in the  specified  environment  and  returns  its  value.
; Expression must  be  a  valid  Scheme  expression  represented  as  data,  and
; environment-specifier must be a value returned by one of the three  procedures
; described below. Implementations  may  extend  eval  to  allow  non-expression
; programs (definitions) as the first argument and  to  allow  other  values  as
; environments, with the restriction that eval is  not  allowed  to  create  new
; bindings in the environments associated with null-environment or
; scheme-report-environment.

;___________________________________________________(apply proc arg1 . . . args)
; Proc must be a procedure and args must be a list. Calls proc with the elements
; of the list (append (list arg 1 . . . ) args) as the actual arguments.


;About 40 mins into SICP-Video-Lectures Lecture 7B  Sussman  begins  to  explain
;'promises' and how 'delay' & 'if' work with the following example of how a  new
;procedure unless could work

;42:45 - 60:06
; In this case, we're going to add a feature. We're going to add the feature of,
; by name parameters, if you will, or delayed parameters. Because, in fact,  the
; default in our Lisp system is by the value of a pointer. A pointer is  copied,
; but the data structure it points at is not.
; 
; But I'd like to, in fact, show you is how you add name arguments as well.  Now
; again, why would we need such a thing?
; 
; Well supposing we wanted to invent certain kinds of what  otherwise  would  be
; special forms, reserve words? But I'd rather not take up reserve words. I want
; procedures that can do things like if. If is special, or cond, or whatever  it
; is. It's the same thing. It's special in that it determines whether or not  to
; evaluate the consequent or the alternative based on the value of the predicate
; part of an expression. So taking the value of one thing determines whether  or
; not to do something else.
; 
; Whereas all the procedures like plus, the ones that we can define  right  now,
; evaluate all of their arguments before application. So, for example, supposing
; I wish to be able to define something like the reverse of if in terms  of  if.
; Call it unless.
; 
; We've a predicate, a consequent, and an alternative. Now what I would like  to
; sort of be able to do is say-- oh, I'll do it in terms of cond. Cond,  if  not
; the predicate, then take the consequent, otherwise, take the alternative.

;Now, what I'd like this to mean, is supposing I do something  like  this.  I'd
;like this unless say if equals one, 0, then the answer is two, otherwise,  the
;quotient of one and 0.

;What I'd like that to mean is the result of substituting  equal  one,  0,  and
;two, and the quotient of one, 0 for p, c, and a. I'd like that  to  mean,  and
;this is funny, I'd like it to transform into or mean cond not  equal  one,  0,
;then the result is two, otherwise I want it to be the quotient one and 0.

;Now, you know that if I were to type this into Lisp, I'd get a two. There's no
;problem with that. However, if I were to type this into Lisp, because all  the
;arguments are evaluated before I start, then I'm going to get an error out  of
;this.

;So that if the substitutions work at all, of course, I  would  get  the  right
;answer. But here's a case where the substitutions don't work.

;I don't get the wrong answer. I get no answer. I get an error.

;Now, however, I'd like to be able to make my definition so that this  kind  of
;thing works. What I want to do is say something special about c and a. I  want
;them to be delayed automatically.

;I don't want them to be evaluated at the time I call. So I'm going to  make  a
;declaration, and then I'm going to see how to implement  such  a  declaration.
;But again, I want you to say to yourself, oh, this  is  an  interesting  kluge
;he's adding in here. The piles of kluges make a big complicated mess.  And  is
;this going to foul up something else that might occur. First  of  all,  is  it
;syntactically unambiguous? Well, it will  be  syntactically  unambiguous  with
;what we've seen so far. But what I'm going to do may, in fact, cause  trouble.
;It may be that the thing I had will conflict with type  declarations  I  might
;want to add in the future for giving some system, some compiler or  something,
;the ability to optimize given the types are known. Or it might  conflict  with
;other types of declarations I might want to make about the formal  parameters.
;So I'm not making a general mechanism here where I can add declarations. And I
;would like to be able to do that. But I don't want to talk  about  that  right
;now. So here I'm going to do, I'm going to build a kluge.
;
;(define (unless p (name c) (name a))
;        (cond ((not p) c)
;              (else a)))

;So we're going to define unless of a predicate-- and I'm going to  call  these
;by name--

;the consequent, and name the alternative.

;Huh, huh-- I got caught in the corner.

;If not p then the result is c, else--

;that's what I'd like.

;Where I can explicitly declare certain of the parameters to be delayed, to  be
;computed later.

;Now, this is actually a very complicated modification to an interpreter rather
;than a simple one.  The  ones  you  saw  before,  dynamic  binding  or  adding
;indefinite argument procedures, is relatively simple. But this one  changes  a
;basic strategy.  The  problem  here  is  that  our  interpreter,  as  written,
;evaluates a combination by evaluating the procedure,  the  operator  producing
;the procedure, and evaluating the operands producing the arguments,  and  then
;doing apply of the procedure to the arguments. However, here, I don't want  to
;evaluate the operands to produce the arguments  until  after  I  examined  the
;procedure to see what the procedure's declarations look like.

;So let's look at that. Here we have a changed evaluator. I'm starting with the
;simple lexical evaluator, not dynamic, but we're going to have to do something
;sort of similar in some ways. Because of the fact that, if I delay a procedure--
;I'm sorry-- delay an argument to a procedure, I'm going to have to attach  and
;environment to it. Remember how Hal implemented delay. Hal  implemented  delay
;as being a procedure of no arguments which does some expression.  That's  what
;delay of the expression is.

;--of that expression.

;This turned into something like this.

;Now, however, if I evaluate  a  lambda  expression,  I  have  to  capture  the
;environment.

;The reason why is because there are variables in there who's meaning I wish to
;derive from the context where this was written.

;(delay e) (λ () e)
;(force e) (e)

;So that's why a lambda does the job. It's the right thing. And such  that  the
;forcing of a delayed expression  was  same  thing  as  calling  that  with  no
;arguments. It's just the opposite of this. Producing  an  environment  of  the
;call which is, in fact, the environment where this was defined with  an  extra
;frame in it that's empty. I don't care about that. Well, if we go back to this
;slide, since it's the case, if we look at this for a second, everything is the
;same as it was before except the case of  applications  or  combinations.  And
;combinations are going to do two things. One, is I have to evaluate the procedure--
;forget the procedure-- by evaluating the operator. That's what you  see  right
;here. I have to make sure that that's current, that is not a  delayed  object,
;and evaluate that to the point where it's forced  now.  And  then  I  have  to
;somehow apply that to the operands. But I have to keep the  environment,  pass
;that environmental along. So some of those operands I may have to delay. I may
;have  to  attach  that  environment  to  those  operands.  This  is  a  rather
;complicated thing happening here. Looking at that in apply.

;Apply, well it has a primitive procedure  thing  just  like  before.  But  the
;compound one is a little more interesting.

;I have to evaluate the body, just as before, in an environment  which  is  the
;result of binding some formal parameters  to  arguments  in  the  environment.
;That's true. The environment is the one that comes  from  the  procedure  now.
;It's a lexical language, statically bound. However, one thing I have to do  is
;strip off the declarations to get the names of the variables. That's what this
;guy does, vnames.  And  the  other  thing  I  have  to  do  is  process  these
;declarations, deciding which of these operands-- that's the operands  now,  as
;opposed to the arguments-- which of these operands to evaluate, and  which  of
;them are to be encapsulated in delays of some sort.

;The other thing you see here is that we got  a  primitive,  a  primitive  like
;plus, had better get at the real operands. So here  is  a  place  where  we're
;going to have to force them. And we're going to look at what evlist  is  going
;to have to do a bunch of forces. So we have two different kinds of evlist now.
;We have evlist and gevlist. Gevlist is going to wrap delays around some things
;and force others, evaluate others. And this guy's going to do some forcing  of
;things. Just looking at this a little bit, this is a game you  must  play  for
;yourself, you know. It's not something that you're going to see  all  possible
;variations on an evaluator talking to me. What you have to do is do  this  for
;yourself. And after you feel this, you play this a bit, you get to see all the
;possible design decisions and what they might mean, and how they interact with
;each other. So what languages might have in them. And what  are  some  of  the
;consistent sets that make a  legitimate  language.  Whereas  what  things  are
;complicated kluges that are just piles of junk.  So  evlist  of  course,  over
;here, just as I said, is a list of operands which are going  to  be  undelayed
;after evaluation. So these are going to be forced, whatever  that's  going  to
;mean. And gevlist, which is the next thing--

;Thank you. What we see here, well there's a couple  of  possibilities.  Either
;it's a normal, ordinary thing, a symbol sitting there like  the  predicate  in
;the unless, and that's what we have here. In which case, this is  intended  to
;be evaluated in applicative order. And it's, essentially,  just  what  we  had
;before. It's mapping eval down the list. In other words, I evaluate the  first
;expression  and  continue  gevlisting  the  CDR  of  the  expression  in   the
;environment. However, it's possible that this is a name parameter. If  it's  a
;name parameter, I want to put a delay in which combines that expression, which
;I'm calling by name, with the environment that's available at  this  time  and
;passing that as the parameter. And this is part of the  mapping  process  that
;you see here.

;The only other interesting place in this interpreter is cond. People  tend  to
;write this thing, and then they leave this one out. There's a place where  you
;have to force. Conditionals have to know whether or not the answer is true  or
;false. It's like a primitive. When you do a conditional, you  have  to  force.
;Now, I'm not going to look at any more of this in any detail.  It  isn't  very
;exciting. And what's left is how  you  make  delays.  Well,  delays  are  data
;structures which contain an expression, an environment, and a  type  on  them.
;And it says they're a thunk. That comes from ALGOL language, and it's  claimed
;to be the sound of something being pushed on a stack. I don't know. I was  not
;an ALGOLician or an ALGOLite or whatever, so I don't know. But that's what was
;claimed. And undelay is something which will recursively undelay thunks  until
;the thunk becomes something which isn't a thunk. This is the way you implement
;a call by name like thing in ALGOL. And that's about all there is.  Are  there
;any questions?

;AUDIENCE: Gerry? PROFESSOR:  Yes,  Vesko?  AUDIENCE:  I  noticed  you  avoided
;calling by name in the primitive procedures, I was wondering  what  cause  you
;have on that? You never need that? PROFESSOR: Vesko is  asking  if  it's  ever
;reasonable to call a primitive procedure by name? The answer is, yes.  There's
;one particular case where it's reasonable, actually two.

;Construction of a data structure like cons where making an array if  you  have
;arrays with any  number  of  elements.  It's  unnecessary  to  evaluate  those
;arguments. All you need is promises to evaluate those arguments if you look at
;them. If I cons together two things, then I could cons together  the  promises
;just as easily as I can cons together the things. And it's not even when I CAR
;CDR them that I have to look at them. That just  gets  out  the  promises  and
;passes them to somebody. That's why the lambda calculus definition, the Alonzo
;Church definition of CAR, CDR, and cons makes sense. It's because no  work  is
;done in CAR, CDR, and cons, it's just shuffling data, it's  just  routing,  if
;you will. However, the things that do have to look at  data  are  things  like
;plus. Because they have a look at the bits that the numbers are made  out  of,
;unless they're lambda calculus numbers which are funny. They have to  look  at
;the bits to be able to crunch them together to do the add.

;So, in fact, data constructors, data selectors, and, in fact, things that side-
;effect data objects don't need to do  any  forcing  in  the  laziest  possible
;interpreters.

;On the other hand predicates on data structures have to.

;Is this a pair? Or is it a symbol? Well, you better find out. You got to  look
;at it then.

;Any other questions?

;Oh, well, I suppose it's time for a break. Thank you.

