f <- function(s) {
    d <- strsplit(s, 'ar', fixed = TRUE)[[1]]
    if (length(d) == 1) {
        return(s)
    } else {
        last_part <- tail(d, n = 1)
        first_parts <- head(d, n = -1)
        first_part <- paste(first_parts, collapse = 'ar')
        return(paste(first_part, 'ar', last_part, sep = ' '))
    }
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('xxxarmmarxx'), 'xxxarmm ar xx')))
}
test_humaneval()
