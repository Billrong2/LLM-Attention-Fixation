f <- function(n) {    p <- ''
    if (n %% 2 == 1) {
        p <- paste0(p, 'sn')
    } else {
        return(n * n)
    }
    for (x in 1:n) {
        if (x %% 2 == 0) {
            p <- paste0(p, 'to')
        } else {
            p <- paste0(p, 'ts')
        }
    }
    return(p)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(1), 'snts')))
}
test_humaneval()
