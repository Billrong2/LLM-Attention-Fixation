fn f(plot: Vec<isize>, delin: isize) -> Vec<isize> {
    if plot.contains(&delin) {
        let split = plot.iter().position(|&x| x == delin).unwrap();
        let mut first = plot[..split].to_vec();
        let mut second = plot[split + 1..].to_vec();
        first.append(&mut second);
        first
    } else {
        plot
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 4], 3), vec![1, 2, 4]);
}
