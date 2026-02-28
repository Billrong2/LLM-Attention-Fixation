import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text.headOption.exists(_.isUpper) && text.tail.exists(_.isLower)) {
            if (text.length > 1 && text.toLowerCase != text) {
                return text.head.toLower + text.tail
            }
        } else if (text.forall(_.isLetter)) {
            return text.capitalize
        }
        return text
    }
    def main(args: Array[String]) = {
    assert(f(("")).equals(("")));
    }

}
