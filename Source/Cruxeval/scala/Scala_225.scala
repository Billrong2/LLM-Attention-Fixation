import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        text.forall(_.isLower)
    }
    def main(args: Array[String]) = {
    assert(f(("54882")) == (false));
    }

}
