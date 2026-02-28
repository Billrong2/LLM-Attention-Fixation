import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, strip_chars : String) : String = {
        text.reverse.dropWhile(strip_chars.contains(_)).reverse.dropWhile(strip_chars.contains(_))
    }
    def main(args: Array[String]) = {
    assert(f(("tcmfsmj"), ("cfj")).equals(("tcmfsm")));
    }

}
