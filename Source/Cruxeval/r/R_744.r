f <- function(text, new_ending) {    result <- strsplit(text, '')[[1]]
    result <- c(result, strsplit(new_ending, '')[[1]])
    paste(result, collapse='')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('jro', 'wdlp'), 'jrowdlp')))
}
test_humaneval()
