f <- function(first, second) {    if(length(first) < 10 || length(second) < 10) {
        return('no')
    }
    for(i in 1:5) {
        if(first[i] != second[i]) {
            return('no')
        }
    }
    c(first, second)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 1), c(1, 1, 2)), 'no')))
}
test_humaneval()
