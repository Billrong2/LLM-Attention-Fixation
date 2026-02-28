fn f(selfie: Vec<isize>) -> Vec<isize> {
    let mut selfie = selfie;
    let lo = selfie.len();
    let mut i = lo as isize - 1;
    while i >= 0 {
        if selfie[i as usize] == selfie[0] {
            selfie.remove(lo - 1);
        }
        i -= 1;
    }
    selfie
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![4, 2, 5, 1, 3, 2, 6]), vec![4, 2, 5, 1, 3, 2]);
}
