fn f(names: Vec<String>) -> isize {
    let mut count: isize = names.len() as isize;
    let mut number_of_names: isize = 0;

    for i in names {
        if i.chars().all(char::is_alphabetic) {
            number_of_names += 1;
        }
    }

    number_of_names
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("sharron"), String::from("Savannah"), String::from("Mike Cherokee")]), 2);
}
