f <- function(items, target) {    
    if (target %in% items) {
        return(which(items == target) - 1)
    }
    return(-1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('1', '+', '-', '**', '//', '*', '+'), '**'), 3)))
}
test_humaneval()
