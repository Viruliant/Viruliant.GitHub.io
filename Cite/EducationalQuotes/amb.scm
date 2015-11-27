#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;    Use of this software and  associated  documentation  files  (the
;    "Software"), is governed by the Creative Commons  Public  Domain
;    License(the "License"). You may obtain a copy of the License at:
;        https://creativecommons.org/licenses/publicdomain/
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/gYF0pW SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(load "SICP.ss")
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

