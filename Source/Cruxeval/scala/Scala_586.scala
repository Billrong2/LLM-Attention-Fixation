import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : Long = {
        text.lastIndexOf(char)
    }
    def main(args: Array[String]) = {
    assert(f(("breakfast"), ("e")) == (2l));
    }

}
