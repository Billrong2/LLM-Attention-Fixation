import scala.math._
import scala.collection.mutable._
object Problem {
    def f(num : Long) : String = {
        if (num > 0 && num < 1000 && num != 6174) {
            "Half Life"
        } else {
            "Not found"
        }
    }
    def main(args: Array[String]) = {
    assert(f((6173l)).equals(("Not found")));
    }

}
