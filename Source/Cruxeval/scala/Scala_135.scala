import scala.math._
object Problem {
    def f() : List[String] = {
        val d = Map(
            "Russia" -> List(("Moscow", "Russia"), ("Vladivostok", "Russia")),
            "Kazakhstan" -> List(("Astana", "Kazakhstan"))
        )
        d.keys.toList
    }
    def main(args: Array[String]) = {
    assert(f().equals((List[String]("Russia", "Kazakhstan"))));
    }

}
