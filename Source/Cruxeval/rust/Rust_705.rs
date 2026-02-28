fn f(cities: Vec<String>, name: String) -> Vec<String> {
    if name.is_empty() {
        return cities;
    } else if !name.is_empty() && name != "cities" {
        return vec![];
    } else {
        return cities.into_iter().map(|city| name.clone() + &city).collect();
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("Sydney"), String::from("Hong Kong"), String::from("Melbourne"), String::from("Sao Paolo"), String::from("Istanbul"), String::from("Boston")], String::from("Somewhere ")), Vec::<String>::new());
}
