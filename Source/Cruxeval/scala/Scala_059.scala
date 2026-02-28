import scala.collection.mutable._
import scala.math._
object Problem {
    def f(s: String): String = {
        val a = s.filter(_ != ' ').toList
        var b = a
        var shouldBreak = false
        for (c <- a.reverse if !shouldBreak) {
            if (c == ' ') {
                b = b.init
            } else {
                shouldBreak = true
            }
        }
        b.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("hi ")).equals(("hi")));
    }

}
