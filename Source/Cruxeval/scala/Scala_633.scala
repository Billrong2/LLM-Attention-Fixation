import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], elem : Long) : Long = {
        val reversedArray = array.reverse
        try {
            val found = reversedArray.indexOf(elem)
            found
        } finally {
            val originalArray = reversedArray.reverse
            originalArray
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](5l.toLong, -3l.toLong, 3l.toLong, 2l.toLong)), (2l)) == (0l));
    }

}
