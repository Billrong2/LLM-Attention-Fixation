import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, pref : String) : String = {
        var result = text
        if (text.startsWith(pref)) {
            val n = pref.length
            val parts = text.substring(n).split("\\.").drop(1) ++ text.substring(0, n).split("\\.").dropRight(1)
            result = parts.mkString(".")
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("omeunhwpvr.dq"), ("omeunh")).equals(("dq")));
    }

}
