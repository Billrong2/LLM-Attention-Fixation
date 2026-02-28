f <- function(input_string, spaces) {    gsub("\t", paste(rep(" ", spaces), collapse = ""), input_string)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a\\tb', 4), 'a\\tb')))
}
test_humaneval()
