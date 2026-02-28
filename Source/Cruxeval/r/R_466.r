f <- function(text) {    length <- nchar(text)
    index <- 1
    while (index <= length && substr(text, index, index) %in% c(" ", "\t", "\n", "\r")) {
        index <- index + 1
    }
    substr(text, index, index + 4)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('-----\t\n\tth\n-----'), '-----')))
}
test_humaneval()
