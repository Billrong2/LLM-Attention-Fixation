import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): String = {
        val ls = ListBuffer[Char]() ++= text
        val length = ls.length
        for (i <- 0 until length) {
            ls.insert(i, ls(i))
        }
        ls.mkString.padTo(length * 2, ' ').mkString
    }
    def main(args: Array[String]) = {
    assert(f(("hzcw")).equals(("hhhhhzcw")));
    }

}
