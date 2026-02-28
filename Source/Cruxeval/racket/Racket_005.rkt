#lang racket

(define (f text lower upper)
  (define count 0)
  (define new-text '())
  (for ([char (in-string text)])
    (let ([new-char 
           (if (char-numeric? char) 
               lower 
               upper)])
      (when (member new-char '(#\p #\C))
        (set! count (+ count 1)))
      (set! new-text (cons new-char new-text))))
  (list count (list->string (apply append (map string->list (reverse new-text))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "DSUWeqExTQdCMGpqur" "a" "x") (list 0 "xxxxxxxxxxxxxxxxxx") 0.001)
))

(test-humaneval)
