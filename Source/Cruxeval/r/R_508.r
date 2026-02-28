f <- function(text, sep, maxsplit) {
    splitted <- strsplit(text, split = sep)[[1]]
    length <- length(splitted)
    new_splitted <- splitted[1:(length %/% 2)]
    new_splitted <- rev(new_splitted)
    new_splitted <- c(new_splitted, splitted[-(1:(length %/% 2))])
    paste(new_splitted, collapse = sep)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ertubwi', 'p', 5), 'ertubwi')))
}
test_humaneval()
