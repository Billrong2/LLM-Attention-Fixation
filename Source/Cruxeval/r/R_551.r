f <- function(data) {    members <- c()
    for (item in names(data)) {
        for (member in data[[item]]) {
            if (!(member %in% members)) {
                members <- c(members, member)
            }
        }
    }
    sort(members)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'inf'" = c('a', 'b'), "'a'" = c('inf', 'c'), "'d'" = c('inf'))), c('a', 'b', 'c', 'inf'))))
}
test_humaneval()
