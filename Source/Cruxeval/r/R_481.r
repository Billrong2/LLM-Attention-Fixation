f <- function(values, item1, item2) {    if (values[length(values)] == item2) {
        if (!(values[1] %in% values[-1])) {
            values <- c(values, values[1])
        }
    } else if (values[length(values)] == item1) {
        if (values[1] == item2) {
            values <- c(values, values[1])
        }
    }
    values
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1), 2, 3), c(1, 1))))
}
test_humaneval()
