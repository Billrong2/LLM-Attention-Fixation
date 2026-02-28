import scala.math._
import scala.collection.mutable._
object Problem {
    def f(input : String) : Boolean = {
        input.forall(!_.isUpper)
    }
    def main(args: Array[String]) = {
    assert(f(("a j c n x X k")) == (false));
    }

}
