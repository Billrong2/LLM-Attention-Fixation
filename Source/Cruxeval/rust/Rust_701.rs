fn f(stg: String, tabs: Vec<String>) -> String {
    let mut stg = stg;
    for tab in tabs {
        stg = stg.trim_end_matches(&tab).to_string();
    }
    stg
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("31849 let it!31849 pass!"), vec![String::from("3"), String::from("1"), String::from("8"), String::from(" "), String::from("1"), String::from("9"), String::from("2"), String::from("d")]), String::from("31849 let it!31849 pass!"));
}
