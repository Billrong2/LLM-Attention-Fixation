import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : String = {
        if(suffix.startsWith("/")) {
            return text + suffix.substring(1)
        } else {
            return text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("hello.txt"), ("/")).equals(("hello.txt")));
    }

}
