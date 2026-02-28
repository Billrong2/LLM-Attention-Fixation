import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = ""
        val mid = (text.length - 1) / 2
        for (i <- 0 until mid) {
            result += text(i)
        }
        for (i <- mid until text.length - 1) {
            result += text(mid + text.length - 1 - i)
        }
        result.padTo(text.length, text.last).mkString
    }
    def main(args: Array[String]) = {
    assert(f(("eat!")).equals(("e!t!")));
    }

}
