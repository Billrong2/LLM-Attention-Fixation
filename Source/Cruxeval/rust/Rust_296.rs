fn f(url: String) -> String {
    url.trim_start_matches("http://www.").to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("https://www.www.ekapusta.com/image/url")), String::from("https://www.www.ekapusta.com/image/url"));
}
