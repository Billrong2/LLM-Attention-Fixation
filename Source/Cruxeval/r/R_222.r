f <- function(mess, char) {
    while(gregexpr(char, substr(mess, 1, nchar(char) - 1)) != -1) {
        mess <- substr(mess, 1, nchar(mess) - nchar(char) - 1)
    }
    return(mess)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('0aabbaa0b', 'a'), '0aabbaa0b')))
}
test_humaneval()
