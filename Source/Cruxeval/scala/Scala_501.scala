import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        val index = text.lastIndexOf(char)
        var result = text.toArray
        var i = index
        while (i > 0) {
            result(i) = result(i - 1)
            result(i - 1) = char.charAt(0)
            i -= 2
        }
        result.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("qpfi jzm"), ("j")).equals(("jqjfj zm")));
    }

}
