import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String, c : String) : Boolean = {
        string.endsWith(c)
    }
    def main(args: Array[String]) = {
    assert(f(("wrsch)xjmb8"), ("c")) == (false));
    }

}
