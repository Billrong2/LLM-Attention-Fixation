f <- function(text, to_place) {    after_place <- substr(text, 1, regexpr(to_place, text)[1])
    before_place <- substr(text, regexpr(to_place, text)[1] + 1, nchar(text))
    paste0(after_place, before_place)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('some text', 'some'), 'some text')))
}
test_humaneval()
