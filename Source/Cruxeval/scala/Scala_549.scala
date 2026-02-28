import scala.math._
import scala.collection.mutable._
object Problem {
    def f(matrix : List[List[Long]]) : List[List[Long]] = {
        matrix.reverse
        var result = ListBuffer[List[Long]]()
        for (primary <- matrix) {
            primary.sorted.reverse
            result += primary
        }
        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[List[Long]](List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong)))).equals((List[List[Long]](List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong)))));
    }

}
