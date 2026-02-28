f <- function(text, prefix) {    prefix_length <- nchar(prefix)
    if (substring(text, 1, prefix_length) == prefix) {
        substr(text, (prefix_length - 1) %/% 2 + 1, 
               (prefix_length + 1) %/% 2 * -1)
    } else {
        text
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('happy', 'ha'), '')))
}
test_humaneval()
