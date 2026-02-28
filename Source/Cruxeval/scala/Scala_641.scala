import scala.math._
import scala.collection.mutable._
object Problem {
    def f(number : String) : Boolean = {
        number.forall(_.isDigit)
    }
    def main(args: Array[String]) = {
    assert(f(("dummy33;d")) == (false));
    }

}
