import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], lst : List[Long]) : List[Long] = {
        val extendedArray = array ++ lst
        val evenNumbers = for (e <- extendedArray if e % 2 == 0) yield e
        val filteredNumbers = for (e <- extendedArray if e >= 10) yield e
        filteredNumbers
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 15l.toLong)), (List[Long](15l.toLong, 1l.toLong))).equals((List[Long](15l.toLong, 15l.toLong))));
    }

}
