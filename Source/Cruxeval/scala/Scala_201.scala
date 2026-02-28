import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var chars = new ListBuffer[Char]()
        for (c <- text) {
            if (c.isDigit) {
                chars += c
            }
        }
        chars.reverse.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("--4yrw 251-//4 6p")).equals(("641524")));
    }

}
