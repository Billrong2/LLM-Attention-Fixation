#lang racket

(define (f text letter)
  (define upper-letter (if (char-lower-case? (string-ref letter 0))
                           (string-upcase letter)
                           letter))
  (define new-text
    (list->string
     (map (lambda (char)
            (if (char=? (char-downcase char) (string-ref upper-letter 0))
                (string-ref upper-letter 0)
                char))
          (string->list text))))
  (string-append (string-upcase (substring new-text 0 1)) (substring new-text 1)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "E wrestled evil until upperfeat" "e") "E wrestled evil until upperfeat" 0.001)
))

(test-humaneval)
