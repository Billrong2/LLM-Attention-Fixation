import scala.collection.mutable._
import scala.math._
object Problem {
    def f(n : Long) : String = {
        var t = 0
        var b = ""
        val digits = n.toString.map(_.asDigit)
        var breakLoop = false
        for (d <- digits if !breakLoop) {
            if (d == 0) {
                t += 1
            } else {
                breakLoop = true
            }
        }
        for (_ <- 0 until t) {
            b += s"1 0 4"
        }
        b += n.toString
        b
    }
    def main(args: Array[String]) = {
    assert(f((372359l)).equals(("372359")));
    }

}
