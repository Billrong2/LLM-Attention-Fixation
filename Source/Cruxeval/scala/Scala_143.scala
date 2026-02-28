import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, n : String) : Boolean = {
        s.toLowerCase == n.toLowerCase
    }
    def main(args: Array[String]) = {
    assert(f(("daaX"), ("daaX")) == (true));
    }

}
