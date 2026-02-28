import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var i = (text.length + 1) / 2
        var result = text.toCharArray()
        while (i < text.length) {
            var t = result(i).toLower
            if (t == result(i)) {
                i += 1
            } else {
                result(i) = t
            }
            i += 2
        }
        result.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("mJkLbn")).equals(("mJklbn")));
    }

}
