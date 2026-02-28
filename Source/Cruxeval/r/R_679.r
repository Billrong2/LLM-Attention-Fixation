f <- function(text) {    if (text == '') {
        return(FALSE)
    }
    first_char <- substr(text, 1, 1)
    if (grepl("^\\d", first_char)) {
        return(FALSE)
    }
    for (last_char in strsplit(text, '')[[1]]) {
        if (last_char != '_' && !grepl("[[:alnum:]_]", last_char)) {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('meet'), TRUE)))
}
test_humaneval()
