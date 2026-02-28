import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var updatedText = text.replace("#", "1").replace("$", "5")
        if (updatedText.forall(_.isDigit)) {
            return "yes"
        } else {
            return "no"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("A")).equals(("no")));
    }

}
