f <- function(n) {    t <- 0
    digits <- as.integer(strsplit(as.character(n), "")[[1]])
    for (d in digits) {
        if (d == 0) { t <- t + 1 }
        else { break }
    }
    b <- paste(c(rep('104', t), n), collapse = "")
    return(b)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(372359), '372359')))
}
test_humaneval()
