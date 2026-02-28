#lang racket

(define (f text)
  (define new-text (regexp-replace* #rx" x" text " x."))
  (if (equal? text (string-titlecase text))
      "correct"
      (string-titlecase (regexp-replace* #rx" x." new-text " x"))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "398 Is A Poor Year To Sow") "correct" 0.001)
))

(test-humaneval)
