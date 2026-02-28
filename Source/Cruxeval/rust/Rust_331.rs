use std::cmp;

fn f(strand: String, zmnc: String) -> isize {
    if strand.find(&zmnc).is_none() {
        return -1;
    }
    let mut strand = strand;
    let mut poz = strand.find(&zmnc).unwrap();
    while poz != std::usize::MAX {
        strand = strand[poz + 1..].to_string();
        poz = strand.find(&zmnc).unwrap_or(std::usize::MAX);
    }
    let last_poz = strand.rfind(&zmnc);
    if last_poz.is_none() {
        return -1;
    }
    last_poz.unwrap() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(""), String::from("abc")), -1);
}
