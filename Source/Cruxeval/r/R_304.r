f <- function(d) {
    keys <- as.numeric(names(d))
    sorted_keys <- sort(keys, decreasing = TRUE)
    key1 <- sorted_keys[1]
    val1 <- d[[as.character(key1)]]
    d[[as.character(key1)]] <- NULL
    sorted_keys <- sort(as.numeric(names(d)), decreasing = TRUE)
    key2 <- sorted_keys[1]
    val2 <- d[[as.character(key2)]]
    d[[as.character(key2)]] <- NULL
    result <- list(val1, val2)
    names(result) <- c(as.character(key1), as.character(key2))
    return(result)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("2" = 3, "17" = 3, "16" = 6, "18" = 6, "87" = 7)), list("87" = 7, "18" = 6))))
}
test_humaneval()
