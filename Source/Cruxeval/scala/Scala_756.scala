import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text.nonEmpty && text.forall(_.isLetterOrDigit) && text.forall(_.isDigit)) {
            return "integer"
        }
        return "string"
    }
    def main(args: Array[String]) = {
    assert(f(("")).equals(("string")));
    }

}
