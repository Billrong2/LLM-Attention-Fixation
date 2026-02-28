object Problem {
    def f(user : Map[String,String]) : (String, String, String, String) = {
        if (user.keys.size > user.values.size) {
            val keys = user.keys.toList
            val keysTuple = (keys(0), keys(1), keys(2), keys(3))
            keysTuple
        } else {
            val values = user.values.toList
            val valuesTuple = (values(0), values(1), values(2), values(3))
            valuesTuple
        }
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]("eating" -> "ja", "books" -> "nee", "piano" -> "coke", "excitement" -> "zoo"))).equals((("ja", "nee", "coke", "zoo"))));
    }

}
