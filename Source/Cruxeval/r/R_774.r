f <- function(num, name) {
    f_str <- 'quiz leader = %s, count = %d'
    sprintf(f_str, name, num)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(23, 'Cornareti'), 'quiz leader = Cornareti, count = 23')))
}
test_humaneval()
