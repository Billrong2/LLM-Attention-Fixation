import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
        var prev = array.head
        var newArray = array.toList
        for (i <- 1 until array.length) {
            if (prev != array(i)) {
                newArray = newArray.updated(i, array(i))
            } else {
                newArray = newArray.patch(i, Nil, 1)
            }
            prev = array(i)
        }
        newArray
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
