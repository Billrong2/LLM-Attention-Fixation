fn f(mut base: Vec<String>, delta: Vec<Vec<String>>) -> Vec<String> {
    for j in 0..delta.len() {
        for i in 0..base.len() {
            if base[i] == delta[j][0] {
                base[i] = delta[j][1].clone();
            }
        }
    }
    base
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("gloss"), String::from("banana"), String::from("barn"), String::from("lawn")], Vec::<Vec<String>>::new()), vec![String::from("gloss"), String::from("banana"), String::from("barn"), String::from("lawn")]);
}
