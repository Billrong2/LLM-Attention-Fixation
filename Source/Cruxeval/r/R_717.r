f <- function(text) {    k <- 1
    l <- nchar(text)
    while (!grepl("[a-zA-Z]", substr(text, l, l))) {
        l <- l - 1
    }
    while (!grepl("[a-zA-Z]", substr(text, k, k))) {
        k <- k + 1
    }
    if (k != 1 | l != nchar(text)) {
        return(substr(text, k, l))
    } else {
        return(substr(text, 1, 1))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('timetable, 2mil'), 't')))
}
test_humaneval()
