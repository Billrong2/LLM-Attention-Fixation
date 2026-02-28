f <- function(needle, haystack) {    count <- 0
    while (grepl(needle, haystack, fixed = TRUE)) {
        haystack <- sub(needle, '', haystack, fixed = TRUE)
        count <- count + 1
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a', 'xxxaaxaaxx'), 4)))
}
test_humaneval()
