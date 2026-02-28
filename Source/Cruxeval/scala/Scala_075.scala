import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], elem : Long) : Long = {
        val ind = array.indexOf(elem)
        ind * 2 + array(array.length - ind - 1) * 3
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-1l.toLong, 2l.toLong, 1l.toLong, -8l.toLong, 2l.toLong)), (2l)) == (-22l));
    }

}
