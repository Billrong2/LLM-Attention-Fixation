f <- function(countries) {    language_country <- list()
    for (i in seq_along(names(countries))) {
        if (is.null(language_country[[countries[[i]]]])) {
            language_country[[countries[[i]]]] <- list()
        }
        language_country[[countries[[i]]]] <- c(language_country[[countries[[i]]]], names(countries)[i])
    }
    return(language_country)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
