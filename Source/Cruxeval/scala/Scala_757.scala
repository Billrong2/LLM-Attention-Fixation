import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String, replace : String) : String = {
      text.replace(char, replace)
    }
    def main(args: Array[String]) = {
    assert(f(("a1a8"), ("1"), ("n2")).equals(("an2a8")));
    }

}
