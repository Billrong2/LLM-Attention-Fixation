f <- function(array) {    
    c <- array
    array_copy <- array

    while (TRUE) {
        c <- append(c, '_')
        if (all(c == array_copy)) {
            array_copy[which(c == '_')] <- ''
            break
        }
    }
    return(array_copy)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c(''))))
}
test_humaneval()
