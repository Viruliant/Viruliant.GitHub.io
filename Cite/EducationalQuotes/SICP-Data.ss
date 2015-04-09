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
;______________________________________________________Data-directed programming
;Exactly 29 mins into SICP-Video-Lectures Lecture 4B Abelson said this:
;So it's really annoying that the bottleneck in this system,  the  thing  that's
;preventing flexibility and change, is completely in the bureaucracy.  It's  not
;anybody who's doing any of the work. Not an uncommon situation, unfortunately.

;Then about x mins into that same lecture he delivers a gem, that you truly need
;to watch to appreciate.
(define (operate op obj)
	(let ((proc (get (type obj) op)))
		(if (not (null? proc))
			(proc (contents obj))
			(error "undefined operator"))))

(define (operate-2 op arg1 arg2)
	(if (eq? (type arg1) (type arg2))
		(let ((proc (get (type arg1) op)))
			(if (not (null? proc))
				(proc (contents arg1) (contents arg2))
				(error "Op undefined on type")
			))
	(error "Arg not same type")))

;Defining Selectors

;;; x^15 + 2x^7 + 5
(polynomial x <term-list>)
;;; term-list is a list of (order, coefficient) pairs
((15 1) (7 2) (0 5))
;And we install it:

(define (make-polynomial var term-list)
	(attach-type 'polynomlial (cons var term-list)))

(define (+poly p1 p2)
	(if (same-var? (var p1) (var p2))
		(make-polynomial
				(var p1)
				(+terms (term-list p1)
								(term-list p2)))
		(error "Polys not in same var")))

(put 'polynomial 'add +poly)
;The heavy lifting is done by +terms

(define (+terms L1 L2)
	(cond ((empty-termlist? L1) L2)
		((empty-termlist? L2) L1)
		(else
			(let ((t1 (first-term L1))
						(t2 (first-term L2)))
				(cond
					((> (order t1) (order t2))
						(adjoin-term
							t1
							(+terms (rest-terms L1) L2)))
					((< (order t1) (order t2))
						(adjoin-term
							t2
							(+terms L1 (rest-terms L2))))
					(else
						(adjoin-term
							(make-term (order t1)
												 (ADD (coeff t1)
															(coeff t2)))
							(+terms (rest-terms L1)
											(rest-terms L2)))))))))
