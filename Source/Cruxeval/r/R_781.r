f <- function(s, ch) {    if (!(ch %in% strsplit(s, '')[[1]])) {
        return('')
    }
    s <- substring(s, regexpr(ch, s) + nchar(ch), nchar(s))
    for (i in 1:nchar(s)) {
        s <- substring(s, regexpr(ch, s) + nchar(ch), nchar(s))
    }
    return(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('shivajimonto6', '6'), '')))
}
test_humaneval()
