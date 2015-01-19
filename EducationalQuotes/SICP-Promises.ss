#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;Copyright © 2014 Roy Pfund                                 All rights reserved.
;Use of this software and associated documentation  files  (the  "Software"), is
;governed by a MIT-style License(the "License") that can be found in the LICENSE
;file. You should have received a copy of the License along with this  Software.
;If not, see http://Viruliant.googlecode.com/git/LICENSE.txt
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/gYF0pW SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(define-syntax λ (syntax-rules () ((_ param body ...) (lambda param body ...))))
(define user-initial-environment (scheme-report-environment 5))(define false #f)
(define true #t)(define (inc x)(+ x 1))(define (dec x)(- x 1))(define nil '())
(define (atom? x) (not (pair? x)))(define (stream-null? x) (null? x))
(define (identity x) x)(define the-empty-stream '())(define mapcar map)
(define-syntax cons-stream (syntax-rules () ((_ A B) (cons A (delay B)))))
;__________________________________________________________________goo.gl/i0fSeQ
(define (current-continuation)(call/cc (λ (cc) (cc cc))))(define fail-stack '())
(define (assert condition) (if (not condition) (fail) #t))
(define (fail); fail : -> ...
	(if (not (pair? fail-stack))
		(error "back-tracking stack exhausted!")
		(begin
			(let ((back-track-point (car fail-stack)))
				(set! fail-stack (cdr fail-stack))
				(back-track-point back-track-point)))))
(define (amb choices); amb : list[a] -> a
	(let ((cc (current-continuation)))
		(cond	((null? choices) (fail))
				((pair? choices) (let ((choice (car choices)))
					(set! choices (cdr choices))
					(set! fail-stack (cons cc fail-stack))
					choice)))))
;_______________________________________________________________________Promises
;About 40 mins into SICP-Video-Lectures Lecture 7B  Sussman  begins  to  explain
;'promises' and how 'delay' & 'if' work with the following example of how a  new
;procedure unless could work

;(define (unless p (name c) (name a))
;        (cond ((not p) c)
;              (else a)))

;(delay e) (λ () e)
;(force e) (e)

;In this case, we're going to add a feature.
;42:53We're going to add the feature of, by name parameters, if you
;42:56will, or delayed parameters.
;43:00Because, in fact, the default in our Lisp system is by the
;43:05value of a pointer.
;43:08A pointer is copied, but the data structure it
;43:10points at is not.
;43:13But I'd like to, in fact, show you is how you add name
;43:17arguments as well.
;43:19Now again, why would we need such a thing?
;43:23Well supposing we wanted to invent certain kinds of what
;43:26otherwise would be special forms, reserve words?
;43:29But I'd rather not take up reserve words.
;43:32I want procedures that can do things like if.
;43:36If is special, or cond, or whatever it is.
;43:39It's the same thing.
;43:40It's special in that it determines whether or not to
;43:43evaluate the consequent or the alternative based on the value
;43:48of the predicate part of an expression.
;43:50So taking the value of one thing determines whether or
;43:54not to do something else.
;43:57Whereas all the procedures like plus, the ones that we
;44:00can define right now, evaluate all of their arguments before
;44:05application.
;44:08So, for example, supposing I wish to be able to define
;44:11something like the reverse of if in terms of if.
;44:19Call it unless.
;44:20
;44:24We've a predicate, a consequent, and an
;44:26alternative.
;44:28Now what I would like to sort of be able to do is say-- oh,
;44:30I'll do it in terms of cond.
;44:32Cond, if not the predicate, then take the consequent,
;44:41otherwise, take the alternative.




;The R5RS Spec
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

