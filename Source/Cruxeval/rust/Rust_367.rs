fn f(nums: Vec<isize>, rmvalue: isize) -> Vec<isize> {
    let mut res = nums.clone();
    while res.contains(&rmvalue) {
        let index = res.iter().position(|&x| x == rmvalue).unwrap();
        let popped = res.remove(index);
        if popped != rmvalue {
            res.push(popped);
        }
    }
    res
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6, 2, 1, 1, 4, 1], 5), vec![6, 2, 1, 1, 4, 1]);
}
