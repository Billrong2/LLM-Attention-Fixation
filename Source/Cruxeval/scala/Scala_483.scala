import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        text.split(char, -1).mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("a"), ("a")).equals((" ")));
    }

}
