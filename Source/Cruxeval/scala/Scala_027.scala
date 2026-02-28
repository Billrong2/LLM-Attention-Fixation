import scala.math._
import scala.collection.mutable._
object Problem {
    def f(w : String) : Boolean = {
        var ls = w.toList
        var omw = ""
        while (ls.nonEmpty) {
            omw += ls.head
            ls = ls.tail
            if (ls.length * 2 > w.length) {
                return w.substring(ls.length) == omw
            }
        }
        false
    }
    def main(args: Array[String]) = {
    assert(f(("flak")) == (false));
    }

}
