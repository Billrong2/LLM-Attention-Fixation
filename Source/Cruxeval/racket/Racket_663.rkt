#lang racket

(define (f container cron)
  (if (not (member cron container))
      container
      (let ([pref (take container (index-of container cron))]
            [suff (drop container (+ (index-of container cron) 1))])
        (append pref suff))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list ) 2) (list ) 0.001)
))

(test-humaneval)
