f <- function(text, count) {    for (i in 1:count) {
        text <- paste(rev(strsplit(text, "")[[1]]), collapse = "")
    }
    text
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('aBc, ,SzY', 2), 'aBc, ,SzY')))
}
test_humaneval()
