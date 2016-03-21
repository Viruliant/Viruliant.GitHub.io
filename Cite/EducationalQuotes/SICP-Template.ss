#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;    Use of this software and  associated  documentation  files  (the
;    "Software"), is governed by the Creative Commons  Public  Domain
;    License(the "License"). You may obtain a copy of the License at:
;        https://creativecommons.org/licenses/publicdomain/
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/gYF0pW SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(load "SICP.ss")
;____________________________________________________________________SICP §4.3.1
;Baker, Cooper, Fletcher, Miller, and Smith live on different floors of an
;apartment house that contains only five floors. Baker does not live on the top
;floor. Cooper does not live on the bottom floor. Fletcher does not live on
;either the top or the bottom floor. Miller lives on a higher floor than does
;Cooper. Smith does not live on a floor adjacent to Fletcher’s. Fletcher does
;not live on a floor adjacent to Cooper’s. Where does everyone live?

(define (multiple-dwelling)
  (let ((baker    (amb (list 1 2 3 4 5))) (cooper (amb (list 1 2 3 4 5)))
        (fletcher (amb (list 1 2 3 4 5))) (miller (amb (list 1 2 3 4 5)))
        (smith    (amb (list 1 2 3 4 5))))

    ;don't allow them to be on the same floor'
    (assert (distinct? (list baker cooper fletcher miller smith)))
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

(display-all (multiple-dwelling) "\n")
;____________________________________________________I have a lovely bunch of λs

;(define (display-all . x)(for-each display x)) was added to the 
;(display-all "\n" ((λ (x y) (+ x y)) 1 2)
;	"\nI " "have " "a " "lovely " "bunch " "of " "λs\n")
;(for-each display '("\nI " "have " "a " "lovely " "bunch " "of " "λs\n"))



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


