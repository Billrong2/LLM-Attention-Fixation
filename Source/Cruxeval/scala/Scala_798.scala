import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, pre : String) : String = {
        if (!text.startsWith(pre)) {
            text
        } else {
            text.stripPrefix(pre)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("@hihu@!"), ("@hihu")).equals(("@!")));
    }

}
