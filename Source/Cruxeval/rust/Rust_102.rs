fn f(names: Vec<String>, winners: Vec<String>) -> Vec<isize> {
    let mut ls: Vec<isize> = names.iter().enumerate()
        .filter_map(|(index, name)| if winners.contains(&name) { Some(index as isize) } else { None })
        .collect();
    ls.sort_unstable_by(|a, b| b.cmp(a));
    ls
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("e"), String::from("f"), String::from("j"), String::from("x"), String::from("r"), String::from("k")], vec![String::from("a"), String::from("v"), String::from("2"), String::from("im"), String::from("nb"), String::from("vj"), String::from("z")]), Vec::<isize>::new());
}
