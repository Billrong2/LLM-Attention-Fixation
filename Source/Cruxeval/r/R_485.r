f <- function(tokens) {    tokens <- strsplit(tokens, " ")[[1]]
    if (length(tokens) == 2) {
        tokens <- rev(tokens)
    }
    result <- paste(sprintf("%-5s", tokens[1]), sprintf("%-5s", tokens[2]))
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('gsd avdropj'), 'avdropj gsd  ')))
}
test_humaneval()
