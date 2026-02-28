import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : Boolean = {
        string == string.toUpperCase()
    }
    def main(args: Array[String]) = {
    assert(f(("Ohno")) == (false));
    }

}
