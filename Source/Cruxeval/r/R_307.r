f <- function(text) {    rtext <- strsplit(text, '')[[1]]
    for (i in 2:(length(rtext) - 1)) {
        rtext <- c(rtext[1:i], '|', rtext[(i+1):length(rtext)])
    }
    paste(rtext, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('pxcznyf'), 'px|||||cznyf')))
}
test_humaneval()
