import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): String = {
        var ls = ListBuffer[Char]()
        ls ++= text
        val total = (text.length - 1) * 2
        for (i <- 1 to total) {
            if (i % 2 == 1) {
                ls += '+'
            } else {
                ls.insert(0, '+')
            }
        }
        ls.mkString("").reverse.padTo(total, ' ').reverse
    }
    def main(args: Array[String]) = {
    assert(f(("taole")).equals(("++++taole++++")));
    }

}
