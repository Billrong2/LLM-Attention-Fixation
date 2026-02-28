f <- function(text, digit) {    count <- nchar(gsub(sprintf("[^%s]", digit), "", text))
    as.numeric(digit) * count
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('7Ljnw4Lj', '7'), 7)))
}
test_humaneval()
