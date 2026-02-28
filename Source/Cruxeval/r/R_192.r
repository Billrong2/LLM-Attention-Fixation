f <- function(text, suffix) {    output <- text
    while (substring(output, nchar(output) - nchar(suffix) + 1, nchar(output)) == suffix) {
        output <- substr(output, 1, nchar(output) - nchar(suffix))
    }
    return(output)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('!klcd!ma:ri', '!'), '!klcd!ma:ri')))
}
test_humaneval()
