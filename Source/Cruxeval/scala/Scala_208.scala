import scala.math._
import scala.collection.mutable._
object Problem {
    def f(items : List[String]) : List[String] = {
        var result = ListBuffer[String]()
        for (item <- items) {
            for (d <- item) {
                if (!d.isDigit) {
                    result += d.toString
                }
            }
        }
        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("123", "cat", "d dee"))).equals((List[String]("c", "a", "t", "d", " ", "d", "e", "e"))));
    }

}
