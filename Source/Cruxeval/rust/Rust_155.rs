fn f(ip: String, n: isize) -> String {
    let mut i = 0;
    let mut out = String::new();
    
    for c in ip.chars() {
        if i == n {
            out.push('\n');
            i = 0;
        }
        i += 1;
        out.push(c);
    }
    
    out
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dskjs hjcdjnxhjicnn"), 4), String::from("dskj
s hj
cdjn
xhji
cnn"));
}
