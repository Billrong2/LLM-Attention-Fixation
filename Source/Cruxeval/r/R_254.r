f <- function(text, repl) {    trans <- chartr(tolower(text), tolower(repl), tolower(text))
    return(trans)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('upper case', 'lower case'), 'lwwer case')))
}
test_humaneval()
