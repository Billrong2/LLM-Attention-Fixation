f <- function(text) {    count <- nchar(text) - nchar(gsub(substr(text, 1, 1), "", text))
    ls <- strsplit(text, "")[[1]]
    for (i in 1:count) {
        ls <- ls[-1]
    }
    paste(ls, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(';,,,?'), ',,,?')))
}
test_humaneval()
