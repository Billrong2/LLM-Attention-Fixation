import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
        var output = array.toList
        output = output.zipWithIndex.map { case (element, index) => if (index % 2 == 0) output(output.length - 1 - index) else element }
        output.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long]())));
    }

}
