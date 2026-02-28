f <- function(album_sales) {    while(length(album_sales) != 1) {
        album_sales <- c(album_sales[-1], album_sales[1])
    }
    return(album_sales[1])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6)), 6)))
}
test_humaneval()
