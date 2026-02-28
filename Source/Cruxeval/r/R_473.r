f <- function(text, value) {    indexes <- which(strsplit(text, '')[[1]] == value)
    new_text <- strsplit(text, '')[[1]]
    new_text <- new_text[-indexes]
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('scedvtvotkwqfoqn', 'o'), 'scedvtvtkwqfqn')))
}
test_humaneval()
