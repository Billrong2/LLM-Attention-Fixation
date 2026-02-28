import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): List[Long] = {
        var d = Map[Char, Int]()
        for (char <- text.replaceAll("-", "").toLowerCase) {
            d += char -> (d.getOrElse(char, 0) + 1)
        }
        val sortedD = d.toList.sortBy(_._2)
        sortedD.map(_._2.toLong)
    }
    def main(args: Array[String]) = {
    assert(f(("x--y-z-5-C")).equals((List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong))));
    }

}
