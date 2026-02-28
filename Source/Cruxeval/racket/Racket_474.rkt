#lang racket

(define (center str width)
  (let* ((str-len (string-length str))
         (pad-len (max 0 (- width str-len)))
         (pad-left (floor (/ pad-len 2)))
         (pad-right (- pad-len pad-left)))
    (string-append (make-string pad-left #\space) str (make-string pad-right #\space))))

(define (f txt marker)
  (define lines (string-split txt "\n"))
  (define a
    (for/list ([line (in-list lines)])
      (center line marker)))
  (string-join a "\n"))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "#[)[]>[^e>
 8" -5) "#[)[]>[^e>
 8" 0.001)
))

(test-humaneval)
