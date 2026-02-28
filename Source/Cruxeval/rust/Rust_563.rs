fn f(text1: String, text2: String) -> isize {
    let mut nums: Vec<isize> = Vec::new();
    for i in 0..text2.len() {
        nums.push(text1.matches(text2.get(i..=i).unwrap()).count() as isize);
    }
    nums.iter().sum()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("jivespdcxc"), String::from("sx")), 2);
}
