fn f(places: Vec<isize>, lazy: Vec<isize>) -> isize {
    let mut places = places;
    places.sort();
    for &l in &lazy {
        if let Some(index) = places.iter().position(|&x| x == l) {
            places.remove(index);
        }
    }
    if places.len() == 1 {
        return 1;
    }
    for (i, &place) in places.iter().enumerate() {
        if places.iter().filter(|&&x| x == place + 1).count() == 0 {
            return (i + 1) as isize;
        }
    }
    return (places.len()) as isize;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![375, 564, 857, 90, 728, 92], vec![728]), 1);
}
