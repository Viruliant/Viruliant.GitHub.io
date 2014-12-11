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

