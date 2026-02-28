import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        text.count(_ == '-') == text.length
    }
    def main(args: Array[String]) = {
    assert(f(("---123-4")) == (false));
    }

}
