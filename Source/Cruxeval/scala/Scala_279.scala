import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var ans = ""
        var t = text
        while (t != "") {
            val parts = t.split("\\(", 2)
            val x = parts(0)
            val sep = parts(1).takeWhile(_ != '(')
            t = parts(1).dropWhile(_ != '(')
            ans = x + sep.replace("(", "|") + ans
            ans = ans + t(0) + ans
            t = t.drop(1)
        }
        ans
    }
    def main(args: Array[String]) = {
    assert(f(("")).equals(("")));
    }

}
