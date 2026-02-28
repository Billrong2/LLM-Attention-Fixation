f <- function(array, value) {
    array <- rev(array)
    array <- array[-length(array)]
    odd <- list()
    while (length(array) > 0) {
      tmp <- list()
      tmp[[array[length(array)]]] <- value
      odd <- c(odd, list(tmp))
      array <- array[-length(array)]
    }
    result <- list()
    while (length(odd) > 0) {
      result <- c(result, odd[[length(odd)]])
      odd <- odd[-length(odd)]
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('23'), 123), list())))
}
test_humaneval()
