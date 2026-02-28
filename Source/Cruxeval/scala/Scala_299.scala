import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        if (!text.endsWith(char)) {
            return f(char + text, char)
        }
        text
    }
    def main(args: Array[String]) = {
    assert(f(("staovk"), ("k")).equals(("staovk")));
    }

}
