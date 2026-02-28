import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        val charIndex = text.indexOf(char)
        var result = List[Char]()
        if (charIndex > 0) {
            result = text.substring(0, charIndex).toList
        }
        result = result ++ char.toList ++ text.substring(charIndex + char.length).toList
        result.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("llomnrpc"), ("x")).equals(("xllomnrpc")));
    }

}
