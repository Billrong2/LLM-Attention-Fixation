import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var ans = new ListBuffer[Char]()
        for (char <- text) {
            if (char.isDigit) {
                ans += char
            } else {
                ans += ' '
            }
        }
        ans.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("m4n2o")).equals((" 4 2 ")));
    }

}
