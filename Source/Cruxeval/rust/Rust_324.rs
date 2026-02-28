fn f(nums: Vec<isize>) -> Vec<isize> {
    let mut asc = nums.clone();
    let mut desc: Vec<isize> = vec![];
    asc.reverse();
    let mid = asc.len() / 2;
    desc.extend_from_slice(&asc[mid..]);
    desc.extend_from_slice(&asc);
    desc.extend_from_slice(&asc[mid..]);
    desc
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<isize>::new()), Vec::<isize>::new());
}
