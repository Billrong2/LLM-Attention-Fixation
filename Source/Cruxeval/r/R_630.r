f <- function(original, string) {
    temp <- original
    for (a in names(string)) {
        b <- string[[a]]
        temp[[as.character(b)]] <- as.integer(a)
    }
    return(temp)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("1" = -9, "0" = -7), list("1" = 2, "0" = 3)), list("1" = -9, "0" = -7, "2" = 1, "3" = 0))))
}
test_humaneval()
