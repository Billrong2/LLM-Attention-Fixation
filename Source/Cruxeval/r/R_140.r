f <- function(st) {
    lower_st <- tolower(st)
    last_h <- tail(max(which(lower_st == 'h')), 1)
    last_i <- max(which(lower_st == 'i'))
    if(last_h >= last_i) {
        return('Hey')
    } else {
        return('Hi')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Hi there'), 'Hey')))
}
test_humaneval()
