f <- function(text) {    for (space in text) {
        if (space == ' ') {
            text <- gsub("^\\s+", "", text)
        } else {
            text <- gsub("cd", space, text)
        }
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('lorem ipsum'), 'lorem ipsum')))
}
test_humaneval()
