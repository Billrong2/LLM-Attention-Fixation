import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): String = {
        val ls = ListBuffer[Char]() ++ text
        for (i <- 0 until ls.length) {
            if (ls(i) != '+') {
                ls.insert(i, '+')
                ls.insert(i, '*')
                return ls.mkString("+")
            }
        }
        ls.mkString("+")
    }
    def main(args: Array[String]) = {
    assert(f(("nzoh")).equals(("*+++n+z+o+h")));
    }

}
