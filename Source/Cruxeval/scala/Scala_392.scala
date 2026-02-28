import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text.toUpperCase == text) {
            return "ALL UPPERCASE"
        }
        text
    }
    def main(args: Array[String]) = {
    assert(f(("Hello Is It MyClass")).equals(("Hello Is It MyClass")));
    }

}
