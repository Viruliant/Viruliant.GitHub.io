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
;_____________________________________________________________________Simplifier
;The simplifier from the 1986 SICP Video available at http://goo.gl/TGXthp
(define (simplifier the-rules)
	(define (simplify-exp exp)
		(try-rules
			(if (compound? exp)
			(simplify-parts exp)
			exp)))
	(define (simplify-parts exp)
		(if (null? exp)
			'()
			(cons (simplify-exp (car exp))
				(simplify-parts (cdr exp)))))
	(define (try-rules exp)
		(define (scan rules)
			(if (null? rules)
				exp
				(let ((dictionary
							(match (pattern (car rules))
								exp
								(make-empty-dictionary))))
					(if (eq? dictionary 'failed)
						(scan (cdr rules))
						(simplify-exp
							(instantiate
								(skeleton (car rules))
								dictionary))))))
		(scan the-rules))
	simplify-exp)

;_______________________________________________________________________________
;After showing the students a list of calculus rules Sussman said this:

;So all rules on this page are  something  like  this;  I  have  patterns,  and
;somehow, I have to produce, given a pattern, a skeleton. This  is  a  rule.  A
;pattern is something that matches, and a skeleton is something you  substitute
;into in order to get a new expression. So what that means is that the  pattern
;is matched against the expression, which is the  source  expression.  And  the
;result of the application of the rule is to produce a  new  expression,  which
;I'll  call  a  target,  by  instantiation  of  a   skeleton.   That's   called
;instantiation. So that is the process by which these rules are described.

;            Rule
;Patterns ---------> Skeleton
;   |                   |
;   |                   |
;   | matched           |Instantiation
;   |                   |
;   |                   |
;   |                   |
;   V                   V
;Expression -------->TargetExpression

;What I'd like to do today is build a language and a means of interpreting that
;language, a means of executing that language, where that language allows us to
;directly express these rules. And  what  we're  going  to  do  is  instead  of
;bringing the rules to the level of thecomputer by writing a  program  that  is
;those rules in the computer's language-- at the  moment,  in  a  Lisp--  we're
;going to bring the computer to the level of us by writing a way by  which  the
;computer can understand rules of this sort.

;This is slightly emphasizing the idea that we had last time that we're  trying
;to make a solution to a class of problems rather than a  particular  one.  The
;problem is if I want to write rules for a different piece of mathematics, say,
;to simple algebraic simplification or something like that, or manipulation  of
;trigonometric functions, I would have to write a different  program  in  using
;yesterday's method. Whereas I would like to encapsulate all of the things that
;are  common  to  both  of  those  programs,  meaning  the  idea  of  matching,
;instantiation, the control structure, which turns out to be  very  complicated
;for such a thing, I'd like to  encapsulate  that  separately  from  the  rules
;themselves.

(define deriv-rules ;; Symbolic Differentiation
	'(
		((dd (?c c) (? v))
			0)
		((dd (?v v) (? v))
			1)
		((dd (?v u) (? v))
			0)
		((dd (+ (? x1) (? x2)) (? v)) (+ (dd (: x1) (: v))
			(dd (: x2) (: v))))
		((dd (* (? x1) (? x2)) (? v)) (+ (* (: x1) (dd (: x2) (: v)))
			(* (dd (: x1) (: v)) (: x2))))
		((dd (** (? x) (?c n)) (? v)) (* (* (: n) (+ (: x) (: (- n 1))))
			(dd (: x) (: v))))
	))
;____________________________________________________________________Expressions
(define (compound? exp) (pair? exp))
(define (constant? exp) (number? exp))
(define (variable? exp) (atom? exp))
;__________________________________________________________________________Rules
(define (pattern rule) (car rule))
(define (skeleton rule) (cadr rule))
;_______________________________________________________________________Patterns
(define (arbitrary-constant? pattern)
	(if (pair? pattern) (eq? (car pattern) '?c) false))
(define (arbitrary-expression? pattern)
	(if (pair? pattern) (eq? (car pattern) '?) false))
(define (arbitrary-variable? pattern)
	(if (pair? pattern) (eq? (car pattern) '?v) false))
(define (variable-name pattern) (cadr pattern))
;________________________________________________________________________Matcher
(define (match pattern expression dictionary)
	(cond ((eq? dictionary 'failed) 'failed)
		((atom? pattern)
			(if (atom? expression)
				(if (eq? pattern expression)
					dictionary
					'failed)
				'failed))
		((arbitrary-constant? pattern)
			(if (constant? expression)
				(extend-dictionary pattern expression dictionary)
				'failed))
		((arbitrary-variable? pattern)
			(if (variable? expression)
				(extend-dictionary pattern expression dictionary)
				'failed))
		((arbitrary-expression? pattern)
			(extend-dictionary pattern expression dictionary))
		((atom? expression) 'failed)
		(else
			(match (cdr pattern)
				(cdr expression)
				(match (car pattern)
					(car expression)
					dictionary)))))

;___________________________________________________________________Dictionaries
(define (make-empty-dictionary) '())
(define (extend-dictionary pat dat dictionary)
	(let ((vname (variable-name pat)))
		(let ((v (assq vname dictionary)))
			;(cond ((null? v);http://stackoverflow.com/a/6976297/144020
			(cond ((not v)
				(cons (list vname dat) dictionary))
				((eq? (cadr v) dat) dictionary)
				(else 'failed)))))
(define (lookup var dictionary)
	(let ((v (assq var dictionary)))
		(if (null? v)
			var
			(cadr v))))

;________________________________________________Skeletons, Evaluations, & Forms
(define (skeleton-evaluation? skeleton)
	(if (pair? skeleton) (eq? (car skeleton) ':) false))
(define (evaluation-expression evaluation) (cadr evaluation))
(define (instantiate skeleton dictionary)
	(cond ((atom? skeleton) skeleton)
		((skeleton-evaluation? skeleton)
			(evaluate (evaluation-expression skeleton)
				dictionary))
		(else (cons (instantiate (car skeleton) dictionary)
				(instantiate (cdr skeleton) dictionary)))))
;_____________________________________________________Evaluate (dangerous magic)
(define (evaluate form dictionary)
	(if (atom? form)
		(lookup form dictionary)
		(apply (eval (lookup (car form) dictionary)
			user-initial-environment)
		(mapcar (λ (v) (lookup v dictionary))
			(cdr form)))))

;_________________________________________________________Example Rule Databases
(define algebra-rules ;; Algebraic simplification
	'(
		(((? op) (?c c1) (?c c2))
			(: (op c1 c2)))
		(((? op) (? e) (?c c))
			((: op) (: c) (: e)))
		((+ 0 (? e))
			(: e))
		((* 1 (? e))
			(: e))
		((* 0 (? e)) 0)
		((* (?c c1) (* (?c c2) (? e)))
			(* (: (* c1 c2)) (: e)))
		((* (? e1) (* (?c c) (? e2)))
			(* (: c) (* (: e1) (: e2))))
		((* (* (? e1) (? e2)) (? e3))
			(* (: e1) (* (: e2) (: e3))))
		((+ (?c c1) (+ (?c c2) (? e)))
			(+ (: (+ c1 c2)) (: e)))
		((+ (? e1) (+ (?c c) (? e2)))
			(+ (: c) (+ (: e1) (: e2))))
		((+ (+ (? e1) (? e2)) (? e3))
			(+ (: e1) (+ (: e2) (: e3))))
		((+ (* (?c c1) (? e)) (* (?c c2) (? e)))
			(* (: (+ c1 c2)) (: e)))
		((* (? e1) (+ (? e2) (? e3)))
			(+ (* (: e1) (: e2))
			(* (: e1) (: e3))))
	))

(define scheme-rules
	'(
		((square (?c n))
			(: (* n n)))
		((fact 0)
			1)
		((fact (?c n))
			(* (: n) (fact (: (- n 1)))))
		((fib 0)
			0)
		((fib 1)
			1)
		((fib (?c n))
			(+ (fib (: (- n 1)))
				(fib (: (- n 2)))))
		(((? op) (?c e1) (?c e2))
			(: (op e1 e2)))
	))
(define algsimp (simplifier algebra-rules))
(define dsimp (simplifier deriv-rules))
(define scheme-evaluator (simplifier scheme-rules))

(for-each display '("dsimp of \"(dd (+ x y) x)\" = " (dsimp '(dd (+ x y) x)) "\n"))
;(for-each display '(display-all "algsimp of \"(dd (+ x y) x)\" = " (algsimp '(dd (+ x y) x)) "\n"))

