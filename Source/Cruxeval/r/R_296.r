f <- function(url) {    sub('http://www.', '', url)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('https://www.www.ekapusta.com/image/url'), 'https://www.www.ekapusta.com/image/url')))
}
test_humaneval()
