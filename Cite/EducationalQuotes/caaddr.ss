http://www.iro.umontreal.ca/~gambit/Sorenson-Clojure-to-Native-via-Scheme.pdf
http://www.infoq.com/presentations/clojure-scheme



(car ‘(1 2 3))
(cdr ‘(1 2 3))
(cadr ‘(1 2 3))
(caddar ‘((1 2 3) 4))


http://lists.racket-lang.org/users/archive/2007-November/021627.html
--------------------------------------------------------------------
(defn machine [stream]
  (let [step {[:init 'c] :more
              [:more 'a] :more
              [:more 'd] :more
              [:more 'r] :end
              [:end nil] :t}]
   (loop [state :init
          stream stream]
    (let [next (step [state (first stream)])]
      (when next
        (if (= next :t)
            :t
            (recur next (rest stream))))))))



“The Swine Before Perl” Shriram Krishnamurthi
---------------------------------------------
(define (init stream)
    (case (car stream)
      ((c) (more (cdr stream)))))
(define (more stream)
   (case (car stream)
     ((a) (more (cdr stream)))
     ((d) (more (cdr stream)))
     ((r) (end  (cdr stream)))))
(define (end stream) (null? stream)) 


hRp://www.eighty-twenty.org/index.cgi/tech/oo-tail-calls-20111001.html	
