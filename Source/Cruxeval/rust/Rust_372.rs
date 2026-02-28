fn f(list_: Vec<String>, num: isize) -> Vec<String> {
    let mut temp: Vec<String> = Vec::new();
    for i in list_ {
        let new_i = std::iter::repeat(format!("{},", i)).take(num as usize / 2).collect::<String>();
        temp.push(new_i);
    }
    temp
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("v")], 1), vec![String::from("")]);
}
