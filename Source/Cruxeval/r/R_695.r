f <- function(d) {    result <- list()
    for (ki in names(d)) {
      result[[ki]] <- list()
      for (kj in seq_along(d[[ki]])) {
        result[[ki]][[kj]] <- list()
        for (kk in names(d[[ki]][[kj]])) {
          result[[ki]][[kj]][[kk]] <- d[[ki]][[kj]][[kk]]
        }
      }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
