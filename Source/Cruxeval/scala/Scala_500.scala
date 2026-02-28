import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, delim : String) : String = {
        text.substring(0, text.reverse.indexOf(delim)).reverse
    }
    def main(args: Array[String]) = {
    assert(f(("dsj osq wi w"), (" ")).equals(("d")));
    }

}
