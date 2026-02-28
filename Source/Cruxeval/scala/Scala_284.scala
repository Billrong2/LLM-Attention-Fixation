import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, prefix : String) : String = {
        var idx = 0
        for (letter <- prefix) {
            if (text.charAt(idx) != letter) {
                return null
            }
            idx += 1
        }
        text.substring(idx)
    }
    def main(args: Array[String]) = {
    assert(f(("bestest"), ("bestest")).equals(("")));
    }

}
