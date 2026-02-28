import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Any], L : Long) : List[Any] = {
        if (L <= 0) {
            array
        } else if (array.length < L) {
            array ++ f(array, L - array.length)
        } else {
            array
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong)), (4l)).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
