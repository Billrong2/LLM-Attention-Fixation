import scala.math._
import scala.collection.mutable._
object Problem {
    def f(x : String) : String = {
        if (x.forall(_.isLower)) {
            x
        } else {
            x.reverse
        }
    }
    def main(args: Array[String]) = {
    assert(f(("ykdfhp")).equals(("ykdfhp")));
    }

}
