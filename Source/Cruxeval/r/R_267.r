f <- function(text, space) {    if(space < 0) {
        return(text)
    }
    return(paste(text, strrep(" ", n = nchar(text) %/% 2 + space)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('sowpf', -7), 'sowpf')))
}
test_humaneval()
