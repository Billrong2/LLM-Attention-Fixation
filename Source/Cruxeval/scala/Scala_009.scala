import scala.math._
import scala.collection.mutable._
object Problem {
    def f(t : String) : Boolean = {
        t.forall(_.isDigit)
    }
    def main(args: Array[String]) = {
    assert(f(("#284376598")) == (false));
    }

}
