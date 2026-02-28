import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : String = {
        if (string.forall(_.isLetterOrDigit)) {
            return "ascii encoded is allowed for this language"
        }
        "more than ASCII"
    }
    def main(args: Array[String]) = {
    assert(f(("Str zahrnuje anglo-ameriæske vasi piscina and kuca!")).equals(("more than ASCII")));
    }

}
