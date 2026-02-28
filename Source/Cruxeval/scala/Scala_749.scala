import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, width : Long) : String = {
        var result = ""
        val lines = text.split('\n')
        for (l <- lines) {
            result += l.padTo(width.toInt, ' ').mkString("")
            result += '\n'
        }
        result = result.dropRight(1) // Remove the very last empty line
        result
    }
    def main(args: Array[String]) = {
    assert(f(("l\nl"), (2l)).equals(("l \nl ")));
    }

}
