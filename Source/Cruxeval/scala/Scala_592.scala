import scala.math._
import scala.collection.mutable._
object Problem {
    def f(numbers : List[Long]) : List[Long] = {
        var new_numbers = ListBuffer[Long]()
        for (i <- numbers.indices) {
            new_numbers += numbers(numbers.length - 1 - i)
        }
        new_numbers.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](11l.toLong, 3l.toLong))).equals((List[Long](3l.toLong, 11l.toLong))));
    }

}
