import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], elem : Long) : Long = {
        if(array.contains(elem)) {
            return array.indexOf(elem)
        }
        return -1
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong, 2l.toLong, 7l.toLong, 1l.toLong)), (6l)) == (0l));
    }

}
