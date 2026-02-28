f <- function(price, product) {    inventory <- c('olives', 'key', 'orange')
    if (!(product %in% inventory)) {
        return(price)
    } else {
        price <- price * 0.85
        inventory <- inventory[inventory != product]
    }
    return(price)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(8.5, 'grapes'), 8.5)))
}
test_humaneval()
