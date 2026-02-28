fn f(mut address: String) -> String {
    let suffix_start = address.find('@').unwrap() + 1;
    if address[suffix_start..].matches('.').count() > 1 {
        let parts: Vec<&str> = address.split('@').collect();
        let suffix_parts: Vec<&str> = parts[1].rsplit('.').take(2).collect();
        let suffix_to_remove = suffix_parts.join(".");
        address = address.replacen(&suffix_to_remove, "", 1);
    }
    address
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("minimc@minimc.io")), String::from("minimc@minimc.io"));
}
