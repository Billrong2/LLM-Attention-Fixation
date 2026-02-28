f <- function(d) {    sorted_pairs <- d[order(sapply(names(d), function(k) nchar(paste0(k, d[[k]]))))]
    ret <- lapply(names(sorted_pairs), function(k) {
        v <- sorted_pairs[[k]]
        if (as.numeric(k) < v) {
            return(c(as.numeric(k), v))
        } else {
            return(NULL)
        }
    })
    ret <- ret[!sapply(ret, is.null)]
    return(ret)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("55" = 4, "4" = 555, "1" = 3, "99" = 21, "499" = 4, "71" = 7, "12" = 6)), list(c(1, 3), c(4, 555)))))
}
test_humaneval()
