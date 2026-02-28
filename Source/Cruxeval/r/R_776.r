f <- function(dictionary) {
    a <- dictionary
    keys_to_delete <- c()
    for (key in names(a)) {
        if (as.integer(key) %% 2 != 0) {
            keys_to_delete <- c(keys_to_delete, key)
            a[paste0("$", key)] <- a[[key]]
        }
    }
    a <- a[setdiff(names(a), keys_to_delete)]
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
