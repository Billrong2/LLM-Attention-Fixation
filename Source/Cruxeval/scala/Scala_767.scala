import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val a = text.trim.split(" ")
        for (i <- 0 until a.length) {
            if (!a(i).forall(_.isDigit)) {
                return "-"
            }
        }
        a.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("d khqw whi fwi bbn 41")).equals(("-")));
    }

}
