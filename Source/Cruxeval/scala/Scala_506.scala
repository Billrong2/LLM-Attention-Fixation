import scala.collection.mutable._
import scala.math._
object Problem {
    def f(n : Long) : String = {
        var p = ""
        if (n % 2 == 1) {
            p += "sn"
        } else {
            return (n * n).toString
        }
        for (x <- 1 to n.toInt) {
            if (x % 2 == 0) {
                p += "to"
            } else {
                p += "ts"
            }
        }
        p
    }
    def main(args: Array[String]) = {
    assert(f((1l)).equals(("snts")));
    }

}
