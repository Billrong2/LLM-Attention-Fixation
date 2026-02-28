f <- function(full, part) {    length <- nchar(part)
    index <- regexpr(part, full)[1]
    count <- 0
    while(index >= 0) {
        full <- substr(full, index + length, nchar(full))
        index <- regexpr(part, full)[1]
        count <- count + 1
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hrsiajiajieihruejfhbrisvlmmy', 'hr'), 2)))
}
test_humaneval()
