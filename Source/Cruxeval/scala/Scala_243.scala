import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : Boolean = {
        char.forall(_.isLower) && text.forall(_.isLower)
    }
    def main(args: Array[String]) = {
    assert(f(("abc"), ("e")) == (true));
    }

}
