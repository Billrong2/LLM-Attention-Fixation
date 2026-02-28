f <- function(text, char, min_count) {    count <- nchar(gsub(sprintf("[^%s]", char), "", text))
    if (count < min_count) {
        return(toupper(text))
    } else {
        return(text)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wwwwhhhtttpp', 'w', 3), 'wwwwhhhtttpp')))
}
test_humaneval()
