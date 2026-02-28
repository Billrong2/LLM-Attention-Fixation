import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, count : Long) : String = {
        var result = text
        for (i <- 1 to count.toInt) {
            result = result.reverse
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("aBc, ,SzY"), (2l)).equals(("aBc, ,SzY")));
    }

}
