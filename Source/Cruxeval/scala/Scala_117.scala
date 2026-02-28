import scala.math._
import scala.collection.mutable._
object Problem {
    def f(numbers : String) : Long = {
        for (i <- 0 until numbers.length) {
            if (numbers.count(_ == '3') > 1) {
                return i
            }
        }
        return -1
    }
    def main(args: Array[String]) = {
    assert(f(("23157")) == (-1l));
    }

}
