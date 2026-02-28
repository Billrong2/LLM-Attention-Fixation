#lang racket

(define (f ip n)
  (define i 0)
  (define out "")
  (for ([c (in-string ip)])
    (when (= i n)
      (set! out (string-append out "\n"))
      (set! i 0))
    (set! i (+ i 1))
    (set! out (string-append out (string c))))
  out)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "dskjs hjcdjnxhjicnn" 4) "dskj
s hj
cdjn
xhji
cnn" 0.001)
))

(test-humaneval)
