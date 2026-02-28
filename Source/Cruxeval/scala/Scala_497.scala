import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(n: Long): List[String] = {
        val b = n.toString.toList
        val result = ListBuffer[String]()
        for (i <- 0 until b.length) {
            if (i >= 2) {
                result += b(i) + "+"
            } else {
                result += b(i).toString
            }
        }
        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((44l)).equals((List[String]("4", "4"))));
    }

}
