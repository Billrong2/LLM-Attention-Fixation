f <- function(text) {    gsub("\n", "\t", text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('apples\n\t\npears\n\t\nbananas'), 'apples\t\t\tpears\t\t\tbananas')))
}
test_humaneval()
