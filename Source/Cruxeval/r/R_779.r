f <- function(text) {    values <- strsplit(text, " ")[[1]]
    sprintf("${first}y, ${second}x, ${third}r, ${fourth}p", 
            first=values[1], second=values[2], third=values[3], fourth=values[4])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('python ruby c javascript'), '${first}y, ${second}x, ${third}r, ${fourth}p')))
}
test_humaneval()
