f <- function(char_freq) {    result <- list()
    for (key in names(char_freq)) {
        result[key] <- char_freq[[key]] %/% 2
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'u'" = 20, "'v'" = 5, "'b'" = 7, "'w'" = 3, "'x'" = 3)), list("'u'" = 10, "'v'" = 2, "'b'" = 3, "'w'" = 1, "'x'" = 1))))
}
test_humaneval()
