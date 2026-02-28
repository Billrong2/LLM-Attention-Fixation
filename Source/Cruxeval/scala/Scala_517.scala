import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        for (i <- text.length - 1 to 1 by -1) {
            if (!text.charAt(i).isUpper) {
                return text.substring(0, i)
            }
        }
        return ""
    }
    def main(args: Array[String]) = {
    assert(f(("SzHjifnzog")).equals(("SzHjifnzo")));
    }

}
