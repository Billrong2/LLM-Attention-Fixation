import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        if (s.forall(_.isLetter)) {
            "yes"
        } else if (s.isEmpty) {
            "str is empty"
        } else {
            "no"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("Boolean")).equals(("yes")));
    }

}
