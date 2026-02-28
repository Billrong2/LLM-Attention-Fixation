import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
        var a = List[Long]()
        val reversedArray = array.reverse
        for (i <- reversedArray.indices) {
            if (reversedArray(i) != 0) {
                a = a :+ reversedArray(i)
            }
        }
        a.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long]())));
    }

}
