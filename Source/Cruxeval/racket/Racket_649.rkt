#lang racket

(define (f text tabsize)
  (string-join
   (map 
    (lambda (t) 
      (string-replace t "\t" (make-string tabsize #\space)))
    (string-split text "\n"))
   "\n"))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "	f9
	ldf9
	adf9!
	f9?" 1) " f9
 ldf9
 adf9!
 f9?" 0.001)
))

(test-humaneval)
