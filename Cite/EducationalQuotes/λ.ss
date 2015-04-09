#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;   Copyright © 2014-2015 Roy Pfund             All rights reserved.
;
;   Use of this software and  associated  documentation  files  (the
;   "Software"), is governed by a MIT-style  License(the  "License")
;   that can be found in the LICENSE file. You should have  received
;   a copy of the License along with this Software. If not, see
;
;       http://Viruliant.Github.io/LICENSE-1.0.txt
;
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/gYF0pW SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(define-syntax λ (syntax-rules () ((_ param body ...) (lambda param body ...))))
(define user-initial-environment (scheme-report-environment 5))(define false #f)
(define true #t)(define (inc x)(+ x 1))(define (dec x)(- x 1))(define nil '())
(define (atom? x) (not (pair? x)))(define (stream-null? x) (null? x))
(define (identity x) x)(define the-empty-stream '())(define mapcar map)
(define-syntax cons-stream (syntax-rules () ((_ A B) (cons A (delay B)))))
(define (amb choices);'amb' from goo.gl/i0fSeQ for use with SICP §4.3.1
	(let ((cc (current-continuation)))
		(cond	((null? choices) (fail))
				((pair? choices) (let ((choice (car choices)))
					(set! choices (cdr choices))
					(set! fail-stack (cons cc fail-stack))
					choice)))))
(define fail-stack '())    (define (fail); fail : -> ...
	(if (not (pair? fail-stack))
		(error "back-tracking stack exhausted!")
		(begin
			(let ((back-track-point (car fail-stack)))
				(set! fail-stack (cdr fail-stack))
				(back-track-point back-track-point)))))
(define (assert condition) (if (not condition) (fail) #t))
(define (current-continuation)(call/cc (λ (cc) (cc cc))))
;__________________________________________________________________goo.gl/jSDcXK
; eval takes an expression and an environment to a value
(define (eval e env) (cond
  ((symbol? e)       (cadr (assq e env)))
  ((eq? (car e) 'λ)  (cons e env))
  (else              (apply (eval (car e) env) (eval (cadr e) env)))))

; apply takes a function and an argument to a value
(define (apply f x)
  (eval (cddr (car f)) (cons (list (cadr (car f)) x) (cdr f))))

; read and parse stdin, then evaluate:
(display (eval (read) '())) (newline)

