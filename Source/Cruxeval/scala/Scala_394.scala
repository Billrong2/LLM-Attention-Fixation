import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        val k = text.split("\n")
        var i = 0
        for (j <- k) {
            if (j.length == 0) {
                return i
            }
            i += 1
        }
        -1
    }
    def main(args: Array[String]) = {
    assert(f(("2 m2 \n\nbike")) == (1l));
    }

}
