import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        var r = ListBuffer[Char]()
        for (i <- s.length - 1 to 0 by -1) {
            r += s(i)
        }
        r.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("crew")).equals(("werc")));
    }

}
