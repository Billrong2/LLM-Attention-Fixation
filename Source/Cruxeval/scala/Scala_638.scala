import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, suffix : String) : String = {
        if (suffix.isEmpty) {
            return s
        } else {
            var result = s
            while (result.endsWith(suffix)) {
                result = result.dropRight(suffix.length)
            }
            return result
        }
    }
    def main(args: Array[String]) = {
    assert(f(("ababa"), ("ab")).equals(("ababa")));
    }

}
