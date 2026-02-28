import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : Long = {
        for (i <- 0 until s.length) {
            if (s(i).isDigit) {
                return i + (if (s(i) == '0') 1 else 0)
            } else if (s(i) == '0') {
                return -1
            }
        }
        return -1
    }
    def main(args: Array[String]) = {
    assert(f(("11")) == (0l));
    }

}
