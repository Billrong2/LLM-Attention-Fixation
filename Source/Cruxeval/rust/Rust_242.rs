fn f(book: String) -> String {
    let a: Vec<&str> = book.rsplitn(2, ':').collect();
    let split_first = a[0].split(' ').collect::<Vec<&str>>();
    let split_last = a[1].split(' ').collect::<Vec<&str>>();
    if split_first[split_first.len()-1] == split_last[0] {
        return f(format!("{} {}", split_first[..split_first.len()-1].join(" "), a[1]).to_string());
    }
    book
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("udhv zcvi nhtnfyd :erwuyawa pun")), String::from("udhv zcvi nhtnfyd :erwuyawa pun"));
}
