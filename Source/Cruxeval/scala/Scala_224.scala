import scala.collection.mutable._
import scala.math._
object Problem {
    def f(array: List[String], value: Long): Map[String, Long] = {
        val reversedArray = array.reverse
        val withoutLastElement = reversedArray.dropRight(1)
        var odd: List[Map[String, Long]] = List()
        var remainingArray = withoutLastElement
        while (remainingArray.nonEmpty) {
            val tmp = Map(remainingArray.head -> value)
            odd = tmp :: odd
            remainingArray = remainingArray.tail
        }
        var result: Map[String, Long] = Map()
        while (odd.nonEmpty) {
            result = result ++ odd.head
            odd = odd.tail
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("23")), (123l)).equals((Map[String,Long]())));
    }

}
