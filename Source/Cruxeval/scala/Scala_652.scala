import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : String = {
        if (string.isEmpty || !string.head.isDigit) {
            return "INVALID"
        }
        var cur = 0
        for (i <- 0 until string.length) {
            cur = cur * 10 + string(i).asDigit
        }
        cur.toString
    }
    def main(args: Array[String]) = {
    assert(f(("3")).equals(("3")));
    }

}
