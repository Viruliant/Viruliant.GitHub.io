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
;'amb' from Matt Might @ goo.gl/i0fSeQ for use with SICP §4.3.1
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
;__________________________________________________________________goo.gl/i0fSeQ

; The following prints (4 3 5)
(let ((a (amb (list 1 2 3 4 5 6 7)))
      (b (amb (list 1 2 3 4 5 6 7)))
      (c (amb (list 1 2 3 4 5 6 7))))
    
  ; We're looking for dimensions of a legal right
  ; triangle using the Pythagorean theorem:
  (assert (= (* c c) (+ (* a a) (* b b))))
  
  (display (list a b c))
  (newline)
  
  ; And, we want the second side to be the shorter one:
  (assert (< b a))

  ; Print out the answer:
  (display (list a b c))
  (newline))



(define (multiple-dwelling)
  (let ((baker    (amb 1 2 3 4 5)) (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5)) (miller (amb 1 2 3 4 5))
        (smith    (amb 1 2 3 4 5)))
    (assert
     (distinct? (list baker cooper fletcher miller smith)))
    (assert (not (= baker 5)))
    (assert (not (= cooper 1)))
    (assert (not (= fletcher 5)))
    (assert (not (= fletcher 1)))
    (assert (> miller cooper))
    (assert (not (= (abs (- smith fletcher)) 1)))
    (assert (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker)       (list 'cooper cooper)
          (list 'fletcher fletcher) (list 'miller miller)
          (list 'smith smith))))



;; SAT-solving with amb.

(define (implies a b) (or (not a) b))
  
;; The is not the most efficient implementation,
;; because a continuation is captured for each
;; occurrence of the same variable, instead of 
;; one for each variable.
(define-syntax sat-solve
  (syntax-rules (and or implies not)
    ((_ formula body)
     ; => 
     (sat-solve formula body formula))
    
    ((_ (not phi) body assertion)
     ; =>
     (sat-solve phi body assertion))
    
    ((_ (and phi) body assertion)
     ; =>
     (sat-solve phi body assertion))
    
    ((_ (and phi1 phi2 ...) body assertion)
     ; =>
     (sat-solve phi1 (sat-solve (and phi2 ...) body assertion)))
    
    ((_ (or phi) body assertion)
     ; =>
     (sat-solve phi body assertion))
    
    ((_ (or phi1 phi2 ...) body assertion)
     ; =>
     (sat-solve phi1 (sat-solve (or phi2 ...) body assertion)))
    
    ((_ (implies phi1 phi2) body assertion)
     ; =>
     (sat-solve phi1 (sat-solve phi2 body assertion)))
    
    ((_ #t body assertion)
     ; =>
     body)
    
    ((_ #f body assertion)
     ; =>
     (fail))
    
    ((_ v body assertion)
     (let ((v (amb (list #t #f))))
       (if (not assertion)
           (fail)
           body)))))
     

; The following prints (#f #f #t)
(display
 (sat-solve (and (implies a (not b))
                 (not a)
                 c)
            (list a b c)))
  
                 
