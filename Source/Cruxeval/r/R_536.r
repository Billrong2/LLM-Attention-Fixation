f <- function(cat) {    digits <- 0
    for (char in strsplit(cat, '')[[1]]) {
        if (grepl('\\d', char)) {
            digits <- digits + 1
        }
    }
    return(digits)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('C24Bxxx982ab'), 5)))
}
test_humaneval()
