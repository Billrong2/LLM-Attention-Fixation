import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : Long = {
        var b = ""
        var c = ""
        for (i <- s) {
            c = c + i
            if (s.lastIndexOf(c) > -1) {
                return s.lastIndexOf(c)
            }
        }
        return 0
    }
    def main(args: Array[String]) = {
    assert(f(("papeluchis")) == (2l));
    }

}
