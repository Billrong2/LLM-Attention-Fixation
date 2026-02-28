fn f(simpons: Vec<String>) -> String {
    let mut simpons = simpons;
    while let Some(pop) = simpons.pop() {
        if pop == pop.chars().nth(0).unwrap().to_uppercase().to_string() + &pop.chars().skip(1).collect::<String>() {
            return pop;
        }
    }
    simpons.pop().unwrap_or_default()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("George"), String::from("Michael"), String::from("George"), String::from("Costanza")]), String::from("Costanza"));
}
