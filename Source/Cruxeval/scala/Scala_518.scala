import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        !text.forall(_.isDigit)
    }
    def main(args: Array[String]) = {
    assert(f(("the speed is -36 miles per hour")) == (true));
    }

}
