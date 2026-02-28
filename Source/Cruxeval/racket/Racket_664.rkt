#lang racket

(define (f tags)
  (let ((resp ""))
    (for/fold ((resp resp))
              ((key (in-list (sort (hash-keys tags) string<?))))
      (string-append resp key " "))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("3" .  "3") ("4" .  "5"))) "3 4 " 0.001)
))

(test-humaneval)
