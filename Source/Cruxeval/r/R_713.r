f <- function(text, char) {    if (char %in% strsplit(text, split = "")[[1]]) {
        text <- strsplit(text, split = char)[[1]]
        text <- sapply(text, function(t) {trimws(t)})
        if (length(text) > 1) {
            return(TRUE)
        }
    }
    return(FALSE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('only one line', ' '), TRUE)))
}
test_humaneval()
