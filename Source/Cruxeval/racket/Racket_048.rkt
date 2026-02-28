#lang racket

(define (f names)
  (cond
    [(empty? names) ""]
    [else
     (define smallest (first names))
     (for ([name (rest names)])
       (when (< name smallest)
         (set! smallest name)))
     (set! names (remove smallest names))
     (string-join smallest)]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) "" 0.001)
))

(test-humaneval)
