import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result: String = ""
        for (i <- text.length - 1 to 0 by -1) {
            result += text(i)
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("was,")).equals((",saw")));
    }

}
