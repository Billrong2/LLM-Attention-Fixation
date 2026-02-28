import scala.math._
import scala.collection.mutable._
object Problem {
    def f(strings : List[String]) : List[String] = {
        var new_strings = ListBuffer[String]()

        for (string <- strings) {
            val first_two = string.take(2)
            if (first_two.startsWith("a") || first_two.startsWith("p")) {
                new_strings += first_two
            }
        }

        new_strings.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("a", "b", "car", "d"))).equals((List[String]("a"))));
    }

}
