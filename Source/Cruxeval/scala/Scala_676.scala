import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, tab_size : Long) : String = {
        text.replaceAll("\t", " " * tab_size.toInt)
    }
    def main(args: Array[String]) = {
    assert(f(("a"), (100l)).equals(("a")));
    }

}
