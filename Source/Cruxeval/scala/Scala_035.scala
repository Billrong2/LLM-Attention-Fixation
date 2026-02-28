import scala.math._
import scala.collection.mutable._
object Problem {
    def f(pattern : String, items : List[String]) : List[Long] = {
        var result = ListBuffer[Long]()
        for (text <- items) {
            val pos = text.lastIndexOf(pattern)
            if (pos >= 0) {
                result += pos.toLong
            }
        }
        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((" B "), (List[String](" bBb ", " BaB ", " bB", " bBbB ", " bbb"))).equals((List[Long]())));
    }

}
