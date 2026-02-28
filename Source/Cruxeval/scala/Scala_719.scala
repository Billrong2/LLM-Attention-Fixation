import scala.math._
import scala.collection.mutable._
object Problem {
    def f(code : String) : String = {
        val lines = code.split("]")
        var result = ListBuffer[String]()
        var level = 0
        for (line <- lines) {
            result += line(0) + " " + "  " * level + line.substring(1)
            level += line.count(_ == '{') - line.count(_ == '}')
        }
        result.mkString("\n")
    }
    def main(args: Array[String]) = {
    assert(f(("if (x) {y = 1;} else {z = 1;}")).equals(("i f (x) {y = 1;} else {z = 1;}")));
    }

}
