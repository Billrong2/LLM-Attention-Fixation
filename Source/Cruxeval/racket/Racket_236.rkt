#lang racket

(define (f array)
    (if (= (length array) 1)
        (apply string-append array)
        (let ((result (list->vector array))
              (i 0))
            (define (loop i)
                (if (< i (- (vector-length result) 1))
                    (begin
                        (vector-set! result (* i 2) (vector-ref result i))
                        (loop (+ i 1)))
                    (apply string-append (vector->list result))))
            (loop i))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "ac8" "qk6" "9wg")) "ac8qk6qk6" 0.001)
))

(test-humaneval)
