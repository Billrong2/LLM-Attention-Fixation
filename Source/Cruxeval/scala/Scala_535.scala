import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : Long) : Boolean = {
        for (num <- n.toString()) {
            if (!"012".contains(num) && !List.range(5, 10).contains(num.toString.toInt)) {
                return false
            }
        }
        return true
    }
    def main(args: Array[String]) = {
    assert(f((1341240312l)) == (false));
    }

}
