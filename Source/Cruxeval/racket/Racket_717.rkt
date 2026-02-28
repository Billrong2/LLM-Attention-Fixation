#lang racket

(define (f text)
  (define (non-alpha-char? c)
    (not (char-alphabetic? c)))
  (define (get-first-alpha-index str pos-dir)
    (define len (string-length str))
    (let loop ([i (if (eq? pos-dir 'start) 0 (- len 1))])
      (cond
        [(non-alpha-char? (string-ref str i)) (loop (if (eq? pos-dir 'start) (+ i 1) (- i 1)))]
        [else i])))
  (define start (get-first-alpha-index text 'start))
  (define end (get-first-alpha-index text 'end))
  (if (not (= start 0))
      (substring text start (+ end 1))
      (substring text 0 1)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "timetable, 2mil") "t" 0.001)
))

(test-humaneval)
