f <- function(array, i_num, elem) {    insert <- function(array, i_num, elem) {
        array <- c(array[1:i_num], elem, array[(i_num + 1):length(array)])
        return(array)
    }
    
    insert(array, i_num, elem)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-4, 1, 0), 1, 4), c(-4, 4, 1, 0))))
}
test_humaneval()
