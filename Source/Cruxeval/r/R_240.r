f <- function(float_number) {    number <- as.character(float_number)
    dot <- regexpr("\\.", number)[[1]]
    if (dot != -1) {
        paste0(substr(number, 1, dot - 1), ".", substr(number, dot + 1, nchar(number)), collapse = "")
    } else {
        paste0(number, ".00")
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(3.121), '3.121')))
}
test_humaneval()
