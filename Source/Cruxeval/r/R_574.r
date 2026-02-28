f <- function(simpons) {    while (length(simpons) > 0) {
        pop <- tail(simpons, 1)
        simpons <- head(simpons, -1)
        if (pop == tools::toTitleCase(pop)) {
            return(pop)
        }
    }
    return(pop)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('George', 'Michael', 'George', 'Costanza')), 'Costanza')))
}
test_humaneval()
