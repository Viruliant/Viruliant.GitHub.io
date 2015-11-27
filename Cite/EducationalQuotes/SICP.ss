#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;    Use of this software and  associated  documentation  files  (the
;    "Software"), is governed by the Creative Commons  Public  Domain
;    License(the "License"). You may obtain a copy of the License at:
;        https://creativecommons.org/licenses/publicdomain/
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book:            goo.gl/gYF0pW
;SICP-Video-Lectures:  goo.gl/3uwWXK
;R5RS:                 goo.gl/z6HMWx

;most of this comes from: http://planet.racket-lang.org/display.ss?package=sicp.plt&owner=neil

;This provides the following for compatibilty with SICP:
;λ user-initial-environment mapcar atom? true false inc dec nil identity
;the-empty-stream stream-null? cons-stream

;;TODO Still need to provide:
;distinct? error sicp-syntax-error random

;(define-syntax error (syntax-rules () ((_ REASON ARG ...) (error REASON ARG ...))))
;(define-syntax sicp-syntax-error (syntax-rules () ((_) #f)))
(define-syntax λ (syntax-rules () ((_ param body ...) (lambda param body ...))))
(define user-initial-environment (scheme-report-environment 5))
(define nil '())
(define false #f)
(define true #t)
(define (inc x)(+ x 1))
(define (dec x)(- x 1))
(define (atom? x) (not (pair? x)))
(define (stream-null? x) (null? x))
(define (identity x) x)
(define the-empty-stream '())
(define mapcar map)
(define-syntax cons-stream (syntax-rules () ((_ A B) (cons A (delay B)))))

;_________________'amb' from Matt Might @ goo.gl/i0fSeQ for use with SICP §4.3.1
(define (amb choices); amb : list[a] -> a
	(let ((cc (current-continuation)))
		(cond	((null? choices) (fail))
				((pair? choices) (let ((choice (car choices)))
					(set! choices (cdr choices))
					(set! fail-stack (cons cc fail-stack))
					choice)))))
(define fail-stack '())(define (fail); fail : -> ...
	(if (not (pair? fail-stack))
		(error "back-tracking stack exhausted!")
		(begin
			(let ((back-track-point (car fail-stack)))
				(set! fail-stack (cdr fail-stack))
				(back-track-point back-track-point)))))
(define (assert condition) (if (not condition) (fail) #t))
(define (current-continuation)(call/cc (λ (cc) (cc cc))))

;__________________Not in the spec for good reason but very useful for beginners
(define (display-all . x)(for-each display x))

