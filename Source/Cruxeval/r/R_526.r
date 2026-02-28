f <- function(label1, char, label2, index) {    m <- max(regexpr(char, label1, fixed = TRUE))
    if (m >= index) {
        substr(label2, 1, m - index + 1)
    } else {
        paste0(substring(label1, m, nchar(label1)), substring(label2, index - m, nchar(label2)))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ekwies', 's', 'rpg', 1), 'rpg')))
}
test_humaneval()
