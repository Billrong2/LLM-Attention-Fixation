fn f(ints: Vec<isize>) -> String {
    let mut counts = vec![0; 301];

    for &i in ints.iter() {
        counts[i as usize] += 1;
    }

    let mut r = Vec::new();
    for i in 0..counts.len() {
        if counts[i] >= 3 {
            r.push(i.to_string());
        }
    }
    
    counts.clear();
    r.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 3, 5, 2, 4, 5, 2, 89]), String::from("2"));
}
