import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], elem : Long) : Long = {
        array.count(_ == elem) + elem
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong, 1l.toLong)), (-2l)) == (-2l));
    }

}
