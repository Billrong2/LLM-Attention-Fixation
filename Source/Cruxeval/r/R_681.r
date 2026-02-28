f <- function(array, ind, elem) {    insert_index <- ifelse(ind < 0, -5, ifelse(ind > length(array), length(array), ind + 1))
    array <- c(array[1:insert_index], elem, array[(insert_index+1):length(array)])
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 5, 8, 2, 0, 3), 2, 7), c(1, 5, 8, 7, 2, 0, 3))))
}
test_humaneval()
