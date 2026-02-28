f <- function(students) {    seatlist <- students
    seatlist <- rev(seatlist)
    cnt <- 0
    for (cnt in 1:length(seatlist)) {
        cnt <- cnt + 2
        if (cnt <= length(seatlist)) {
            seatlist[cnt - 1:cnt] <- c('+')
        } else {
            seatlist[cnt - 1] <- '+'
        }
    }
    seatlist <- c(seatlist, '+')
    return(seatlist)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('r', '9')), c('9', '+', '+', '+'))))
}
test_humaneval()
