#lang racket

(define (string-index str ch)
  (for/first
   ([i (in-range (string-length str))]
    #:when (char=? ch (string-ref str i)))
   i))

(define (string-min str)
  (apply min (map char->integer (string->list str))))

(define (f text s e)
  (define sublist (substring text s e))
  (if (string=? sublist "")
      -1
      (string-index sublist (integer->char (string-min sublist)))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "happy" 0 3) 1 0.001)
))

(test-humaneval)
