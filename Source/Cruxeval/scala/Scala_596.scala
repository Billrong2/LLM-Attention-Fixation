import scala.math._
import scala.collection.mutable._
object Problem {
    def f(txt : List[String], alpha : String) : List[String] = {
        var sortedTxt = txt.sorted
        if (sortedTxt.indexOf(alpha) % 2 == 0) {
            return sortedTxt.reverse
        } else {
            return sortedTxt
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("8", "9", "7", "4", "3", "2")), ("9")).equals((List[String]("2", "3", "4", "7", "8", "9"))));
    }

}
