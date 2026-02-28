import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, chars : String) : String = {
        text.stripSuffix(chars)
    }
    def main(args: Array[String]) = {
    assert(f(("ha"), ("")).equals(("ha")));
    }

}
