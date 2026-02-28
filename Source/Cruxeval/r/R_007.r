f <- function(lst) {    original <- lst
    while(length(lst) > 1) {
        lst <- lst[-length(lst)]
        for (i in seq_along(lst)) {
            lst <- lst[-i]
        }
    }
    lst <- original
    if (length(lst) > 0) {
        lst <- lst[-1]
    }
    return(lst)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
