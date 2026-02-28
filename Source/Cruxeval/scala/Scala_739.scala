import scala.math._
import scala.collection.mutable._
object Problem {
    def f(st : String, pattern : List[String]) : Boolean = {
        var s = st
        for (p <- pattern) {
            if (!s.startsWith(p)) {
                return false
            }
            s = s.substring(p.length)
        }
        true
    }
    def main(args: Array[String]) = {
    assert(f(("qwbnjrxs"), (List[String]("jr", "b", "r", "qw"))) == (false));
    }

}
