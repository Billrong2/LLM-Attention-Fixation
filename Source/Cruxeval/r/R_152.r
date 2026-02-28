f <- function(text) {   
    n <- 0
    for (char in strsplit(text, "")[[1]]) {
        if (grepl("[A-Z]", char)) {
            n <- n + 1
        }
    }
    return(n)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('AAAAAAAAAAAAAAAAAAAA'), 20)))
}
test_humaneval()
