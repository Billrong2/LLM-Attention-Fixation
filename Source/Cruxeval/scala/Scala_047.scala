import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        val length = text.length
        val half = length / 2
        val encode = text.take(half).getBytes("US-ASCII")
        if (text.drop(half) == new String(encode, "US-ASCII")) {
            true
        } else {
            false
        }
    }
    def main(args: Array[String]) = {
    assert(f(("bbbbr")) == (false));
    }

}
