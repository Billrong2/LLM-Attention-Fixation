fn f(s1: String, s2: String) -> Vec<isize> {
    let mut res: Vec<isize> = vec![];
    let mut i = s1.rfind(&s2);
    while let Some(index) = i {
        res.push(index as isize + s2.len() as isize - 1);
        i = s1[..index].rfind(&s2);
    }
    res
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abcdefghabc"), String::from("abc")), vec![10, 2]);
}
