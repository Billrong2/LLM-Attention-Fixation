import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : Boolean = {
        text.count(_.toString == char) % 2 != 0
    }
    def main(args: Array[String]) = {
    assert(f(("abababac"), ("a")) == (false));
    }

}
