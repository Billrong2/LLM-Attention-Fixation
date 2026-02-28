fn f(vectors: Vec<Vec<isize>>) -> Vec<Vec<isize>> {
    let mut sorted_vecs: Vec<Vec<isize>> = vec![];

    for mut vec in vectors {
        vec.sort_unstable();
        sorted_vecs.push(vec);
    }

    sorted_vecs
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(Vec::<Vec<isize>>::new()), Vec::<Vec<isize>>::new());
}
