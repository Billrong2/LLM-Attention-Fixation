f <- function(line) {    a <- strsplit(gsub("[^[:alnum:]]", "", line), "")[[1]]
    paste(a, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('"\\%$ normal chars $%~ qwet42\''), 'normalcharsqwet42')))
}
test_humaneval()
