import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        var ls = text.toList
        if (ls.count(_ == value) % 2 == 0) {
            while (ls.contains(value)) {
                ls = ls.filterNot(_ == value)
            }
        } else {
            ls = List()
        }
        ls.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("abbkebaniuwurzvr"), ("m")).equals(("abbkebaniuwurzvr")));
    }

}
