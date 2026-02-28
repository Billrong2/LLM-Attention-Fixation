import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : Boolean = {
        val l = s.toList.map(_.toLower)
        for (i <- 0 until l.length) {
            if (!l(i).isDigit) {
                return false
            }
        }
        true
    }
    def main(args: Array[String]) = {
    assert(f(("")) == (true));
    }

}
