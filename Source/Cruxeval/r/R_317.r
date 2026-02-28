f <- function(text, a, b) {    text <- gsub(a, b, text)
    gsub(b, a, text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(' vup a zwwo oihee amuwuuw! ', 'a', 'u'), ' vap a zwwo oihee amawaaw! ')))
}
test_humaneval()
