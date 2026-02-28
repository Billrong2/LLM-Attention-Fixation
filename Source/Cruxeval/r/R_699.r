f <- function(text, elem) {
    if (elem != '') {
        while(substr(text, 1, nchar(elem)) == elem) {
            text <- substr(text, nchar(elem) + 1, nchar(text))
        }
        while(substr(elem, 1, nchar(text)) == text) {
            elem <- substr(elem, nchar(text) + 1, nchar(elem))
        }
    }
    return(c(elem, text))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('some', '1'), c('1', 'some'))))
}
test_humaneval()
