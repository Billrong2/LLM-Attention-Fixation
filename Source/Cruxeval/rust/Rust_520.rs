fn f(mut album_sales: Vec<isize>) -> isize {
    while album_sales.len() != 1 {
        let first_element = album_sales.remove(0);
        album_sales.push(first_element);
    }
    album_sales[0]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6]), 6);
}
