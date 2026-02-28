import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], elem : Long) : Long = {
        val strElem = elem.toString()
        var count = 0
        for (i <- array) {
            if (i.toString == strElem) {
                count += 1
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-1l.toLong, 2l.toLong, 1l.toLong, -8l.toLong, -8l.toLong, 2l.toLong)), (2l)) == (2l));
    }

}
