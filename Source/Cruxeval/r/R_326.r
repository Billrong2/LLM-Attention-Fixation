f <- function(text) {    number <- 0
    for (t in strsplit(text, split = "")[[1]]) {
        if (grepl("[0-9]", t)) {
            number <- number + 1
        }
    }
    return(number)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Thisisastring'), 0)))
}
test_humaneval()
