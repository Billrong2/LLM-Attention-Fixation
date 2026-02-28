f <- function(text, length) {    
    length <- ifelse(length < 0, -length, length)
    output <- ''
    for (idx in 1:length) {
        idx <- (idx - 1) %% nchar(text) + 1
        if (substr(text, idx, idx) != ' ') {
            output <- paste0(output, substr(text, idx, idx))
        } else {
            break
        }
    }
    output
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('I got 1 and 0.', 5), 'I')))
}
test_humaneval()
