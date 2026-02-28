f <- function(value, char) {    total <- 0
    for (c in strsplit(value, '')[[1]]) {
        if (c == char || tolower(c) == char) {
            total <- total + 1
        }
    }
    total
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('234rtccde', 'e'), 1)))
}
test_humaneval()
