import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var g = ""
        var field = ""
        field = text.replace(" ", "")
        g = text.replace("0", " ")
        val result = text.replace("1", "i")
        result
    }
    def main(args: Array[String]) = {
    assert(f(("00000000 00000000 01101100 01100101 01101110")).equals(("00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0")));
    }

}
