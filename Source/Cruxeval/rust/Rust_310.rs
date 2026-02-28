fn f(strands: Vec<String>) -> String {
    let mut subs = strands.clone();
    for i in 0..subs.len() {
        for _ in 0..subs[i].len() / 2 {
            let first = subs[i].remove(0);
            let last = subs[i].pop().unwrap();
            subs[i].push(first);
            subs[i].insert(0, last);
        }
    }
    subs.join("")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("__"), String::from("1"), String::from("."), String::from("0"), String::from("r0"), String::from("__"), String::from("a_j"), String::from("6"), String::from("__"), String::from("6")]), String::from("__1.00r__j_a6__6"));
}
