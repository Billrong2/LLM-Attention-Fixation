import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var n = 0
        for (char <- text) {
            if (char.isUpper) {
                n += 1
            }
        }
        n
    }
    def main(args: Array[String]) = {
    assert(f(("AAAAAAAAAAAAAAAAAAAA")) == (20l));
    }

}
