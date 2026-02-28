import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        try {
            text.forall(_.isLetter)
        } catch {
            case e: Exception => false
        }
    }
    def main(args: Array[String]) = {
    assert(f(("x")) == (true));
    }

}
