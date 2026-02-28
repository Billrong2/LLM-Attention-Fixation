import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, search : String) : Boolean = {
        search.startsWith(text) || false
    }
    def main(args: Array[String]) = {
    assert(f(("123"), ("123eenhas0")) == (true));
    }

}
