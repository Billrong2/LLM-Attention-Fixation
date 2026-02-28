f <- function(text) {    t <- strsplit(text, '')[[1]]
    t <- t[-((length(t) %/% 2) + 1)]
    t <- c(t, tolower(text))
    return(paste(t, collapse = ':'))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Rjug nzufE'), 'R:j:u:g: :z:u:f:E:rjug nzufe')))
}
test_humaneval()
