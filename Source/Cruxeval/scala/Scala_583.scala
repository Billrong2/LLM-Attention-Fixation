import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, ch : String) : String = {
        val result = new ListBuffer[String]()
        for (line <- text.split("\n")) {
            if (line.length > 0 && line(0) == ch(0)) {
                result += line.toLowerCase()
            } else {
                result += line.toUpperCase()
            }
        }
        result.mkString("\n")
    }
    def main(args: Array[String]) = {
    assert(f(("t\nza\na"), ("t")).equals(("t\nZA\nA")));
    }

}
