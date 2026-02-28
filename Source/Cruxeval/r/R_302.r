f <- function(string) {    gsub('needles', 'haystacks', string)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wdeejjjzsjsjjsxjjneddaddddddefsfd'), 'wdeejjjzsjsjjsxjjneddaddddddefsfd')))
}
test_humaneval()
