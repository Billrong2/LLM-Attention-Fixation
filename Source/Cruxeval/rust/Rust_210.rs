fn f(n: isize, m: isize, num: isize) -> isize {
    let mut x_list: Vec<isize> = (n..=m).collect();
    let mut j = 0;
    loop {
        j = (j + num).rem_euclid(x_list.len() as isize);
        if x_list[j as usize] % 2 == 0 {
            return x_list[j as usize];
        }
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(46, 48, 21), 46);
}
