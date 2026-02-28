import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(lst: List[Long]): Boolean = {
        val mutableList = ListBuffer(lst: _*)
        mutableList.clear()
        for (i <- lst) {
            if (i == 3) {
                return false
            }
        }
        true
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 0l.toLong))) == (true));
    }

}
