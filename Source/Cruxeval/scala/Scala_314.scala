import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text.contains(',')) {
            val parts = text.split(",", 2)
            parts(1) + " " + parts(0)
        } else {
            ", " + text.split(" ").last + " 0"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("244, 105, -90")).equals((" 105, -90 244")));
    }

}
