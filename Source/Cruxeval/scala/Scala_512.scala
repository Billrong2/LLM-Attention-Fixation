import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : Boolean = {
        s.length == s.count(_ == '0') + s.count(_ == '1')
    }
    def main(args: Array[String]) = {
    assert(f(("102")) == (false));
    }

}
