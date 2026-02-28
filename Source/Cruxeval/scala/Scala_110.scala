import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var a = List("")
        var b = ""
        for (i <- text) {
            if (!i.isWhitespace) {
                a = a :+ b
                b = ""
            } else {
                b += i
            }
        }
        a.length
    }
    def main(args: Array[String]) = {
    assert(f(("       ")) == (1l));
    }

}
