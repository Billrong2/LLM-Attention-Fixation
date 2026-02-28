use std::str;

fn f(sample: String) -> usize {
    let bytes = sample.as_bytes();
    let mut i = 0;
    while i < bytes.len() && bytes[i] != b'/' as u8 {
        i += 1;
    }
    if i == bytes.len() {
        return 0;
    }
    let mut j = i;
    while j < bytes.len() && bytes[j] == b'/' as u8 {
        j += 1;
    }
    if j == bytes.len() {
        return sample.rfind('/').unwrap()
    }
    let slice = &sample[..j];
    slice.rfind('/').unwrap()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("present/here/car%2Fwe")), 7);
}
