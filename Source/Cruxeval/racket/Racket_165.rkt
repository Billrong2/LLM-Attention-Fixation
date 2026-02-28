#lang racket

(define (ascii-only? s)
  (let loop ([i 0])
    (cond
      [(= i (string-length s)) #t]
      [(> (char->integer (string-ref s i)) 127) #f]
      [else (loop (+ i 1))])))

(define (f text lower upper)
  (ascii-only? (substring text lower upper)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "=xtanp|sugv?z" 3 6) #t 0.001)
))

(test-humaneval)
