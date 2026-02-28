import scala.math._
import scala.collection.mutable._

object Problem {
    def f(line : String, char : String) : String = {
        val count = line.count(_ == char.head)
        var newLine = line
        for (i <- count+1 to 1 by -1) {
            val padding = (newLine.length + i / char.length) - newLine.length
            val leftPadding = char * (padding / 2)
            val rightPadding = char * ceil(padding / 2.0).toInt
            newLine = leftPadding + newLine + rightPadding
        }
        newLine
    }
    def main(args: Array[String]) = {
    assert(f(("$78"), ("$")).equals(("$$78$$")));
    }

}
