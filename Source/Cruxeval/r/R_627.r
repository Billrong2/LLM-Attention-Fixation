f <- function(parts) {
    parts_dict <- list()
    for (part in parts) {
        parts_dict[[part[[1]]]] <- part[[2]]
    }
    return(as.integer(unlist(parts_dict)))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(list('u', 1), list('s', 7), list('u', -5))), c(-5, 7))))
}
test_humaneval()
