f <- function(graph) {    new_graph <- list()
    for (key in names(graph)) {
        new_graph[[key]] <- list()
        for (subkey in names(graph[[key]])) {
            new_graph[[key]][[subkey]] <- ''
        }
    }
    return(new_graph)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list()), list())))
}
test_humaneval()
