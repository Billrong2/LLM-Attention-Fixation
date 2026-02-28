f <- function(letters) {    count <- 0
    for (l in strsplit(letters, '')[[1]]) {
        if (grepl('\\d', l)) {
            count <- count + 1
        }
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dp ef1 gh2'), 2)))
}
test_humaneval()
