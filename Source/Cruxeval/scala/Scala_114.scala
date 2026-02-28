import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, sep : String) : List[String] = {
        text.split(sep, -1).toList
    }
    def main(args: Array[String]) = {
    assert(f(("a-.-.b"), ("-.")).equals((List[String]("a", "", "b"))));
    }

}
