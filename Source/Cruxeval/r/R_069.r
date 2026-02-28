f <- function(student_marks, name) {    if (name %in% names(student_marks)) {
        value <- student_marks[[name]]
        student_marks[[name]] <- NULL
        return(value)
    } else {
        return('Name unknown')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'882afmfp'" = 56), '6f53p'), 'Name unknown')))
}
test_humaneval()
