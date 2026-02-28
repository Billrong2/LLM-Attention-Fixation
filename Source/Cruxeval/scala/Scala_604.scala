import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, start : String) : Boolean = {
        text.startsWith(start)
    }
    def main(args: Array[String]) = {
    assert(f(("Hello world"), ("Hello")) == (true));
    }

}
