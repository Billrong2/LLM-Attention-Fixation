fn f(row: String) -> (usize, usize) {
    (row.matches('1').count(), row.matches('0').count())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("100010010")), (3, 6));
}
