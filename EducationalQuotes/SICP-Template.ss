#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;Copyright © 2014 Roy Pfund                                 All rights reserved.
;Use of this software and associated documentation  files  (the  "Software"), is
;governed by a MIT-style License(the "License") that can be found in the LICENSE
;file. You should have received a copy of the License along with this  Software.
;If not, see http://Viruliant.googlecode.com/git/LICENSE.txt
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/AmyAhS SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(define-syntax λ (syntax-rules () ((_ param body ...) (lambda param body ...))))
(define user-initial-environment (scheme-report-environment 5))(define false #f)
(define true #t)(define (inc x)(+ x 1))(define (dec x)(- x 1))(define nil '())
(define (atom? x) (not (pair? x)))(define (stream-null? x) (null? x))
(define (identity x) x)(define the-empty-stream '())(define mapcar map)
(define-syntax cons-stream (syntax-rules () ((_ A B) (cons A (delay B)))))
;___________________________________________________________________________xtra
(define (current-continuation) (call/cc (λ (cc) (cc cc))))
(define (display-all . x)(for-each display x))
;____________________________________________________I have a lovely bunch of λs
(display-all "\n" ((λ (x y) (+ x y)) 1 2)
	"\nI " "have " "a " "lovely " "bunch " "of " "λs\n")

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


