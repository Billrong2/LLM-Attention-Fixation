import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = ""
        var i = text.length - 1
        while (i >= 0) {
            val c = text(i)
            if (c.isLetter) {
                result += c
            }
            i -= 1
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("102x0zoq")).equals(("qozx")));
    }

}
