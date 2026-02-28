import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        s.toLowerCase
    }
    def main(args: Array[String]) = {
    assert(f(("abcDEFGhIJ")).equals(("abcdefghij")));
    }

}
