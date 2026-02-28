f <- function(text, pref) {    if (is.list(pref)) {
        sapply(pref, function(x) grepl(paste0("^", x), text))
    } else {
        grepl(paste0("^", pref), text)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Hello World', 'W'), FALSE)))
}
test_humaneval()
