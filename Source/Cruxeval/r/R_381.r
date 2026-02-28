f <- function(text, num_digits) {    width <- max(1, num_digits)
    sprintf(paste0("%0", width, "d"), as.numeric(text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('19', 5), '00019')))
}
test_humaneval()
