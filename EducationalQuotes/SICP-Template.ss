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
;____________________________________________________I have a lovely bunch of λs

;(define (display-all . x)(for-each display x))
;(display-all "\n" ((λ (x y) (+ x y)) 1 2)
;	"\nI " "have " "a " "lovely " "bunch " "of " "λs\n")
(for-each display '("\nI " "have " "a " "lovely " "bunch " "of " "λs\n"))

;This Template provides the following for compatibilty with SICP:
;λ user-initial-environment mapcar atom? true false inc dec nil identity
;the-empty-stream stream-null? cons-stream

;;TODO
;;still need to provide:
;;error sicp-syntax-error random
;(define-syntax error (syntax-rules () ((_ REASON ARG ...) (error REASON ARG ...))))
;(define-syntax sicp-syntax-error (syntax-rules () ((_) #f)))


;;;; Return the first element in LST for which WANTED? returns a true value.
;;http://community.schemewiki.org/?call-with-current-continuation
;(define (search wanted? lst)
;	(call/cc (λ (return)
;			(for-each (lambda (element)
;				(if (wanted? element)
;					(return element)))
;				lst)
;			#f)
;	))


