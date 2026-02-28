import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, substr : String, occ : Long) : Long = {
        var n = 0
        var currentText = text
        while (true) {
            val i = currentText.lastIndexOf(substr)
            if (i == -1) {
                return -1
            } else if (n == occ) {
                return i
            } else {
                n += 1
                currentText = currentText.substring(0, i)
            }
        }
        -1
    }
    def main(args: Array[String]) = {
    assert(f(("zjegiymjc"), ("j"), (2l)) == (-1l));
    }

}
