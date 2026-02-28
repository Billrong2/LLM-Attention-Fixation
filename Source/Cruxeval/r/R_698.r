f <- function(text) {    paste0(Filter(function(x) x != ')', strsplit(text, '')[[1]]), collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('(((((((((((d))))))))).))))((((('), '(((((((((((d.(((((')))
}
test_humaneval()
