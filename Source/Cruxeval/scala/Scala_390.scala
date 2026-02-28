import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        if (text.trim.isEmpty) {
            return text.trim.length
        } else {
            return -1
        }
    }
    def main(args: Array[String]) = {
    assert(f((" 	 ")) == (0l));
    }

}
