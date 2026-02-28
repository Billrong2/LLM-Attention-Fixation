import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, n : Long) : String = {
        if (n < 0 || text.length <= n) text
        else {
            val result = text.substring(0, n.toInt)
            var i = result.length - 1
            while (i >= 0 && result(i) == text(i)) {
                i -= 1
            }
            text.substring(0, i + 1)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("bR"), (-1l)).equals(("bR")));
    }

}
