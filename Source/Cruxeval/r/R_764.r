f <- function(text, old, new) {    text2 <- gsub(old, new, text, fixed = TRUE)
    old2 <- strsplit(old, "")[[1]]
    old2 <- paste(rev(old2), collapse = "")
    while (grepl(old2, text2)) {
        text2 <- gsub(old2, new, text2, fixed = TRUE)
    }
    return(text2)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('some test string', 'some', 'any'), 'any test string')))
}
test_humaneval()
