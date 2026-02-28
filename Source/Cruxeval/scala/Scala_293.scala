import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val s = text.toLowerCase()
        for (i <- 0 until s.length) {
            if (s(i) == 'x') {
                return "no"
            }
        }
        text.toUpperCase()
    }
    def main(args: Array[String]) = {
    assert(f(("dEXE")).equals(("no")));
    }

}
