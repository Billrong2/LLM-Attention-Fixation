f <- function(dict) {    even_keys <- c()
    for (key in names(dict)) {
        key_num <- as.numeric(key)
        if (key_num %% 2 == 0) {
            even_keys <- c(even_keys, key_num)
        }
    }
    return(even_keys)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("4" = 'a')), c(4))))
}
test_humaneval()
