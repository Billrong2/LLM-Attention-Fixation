import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        if (s.forall(_.isLetterOrDigit)) {
            return "True"
        } else {
            return "False"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("777")).equals(("True")));
    }

}
