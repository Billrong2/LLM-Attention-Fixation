import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(array: List[Long], elem: Long): List[Long] = {
        var k = 0
        var found = false
        val l = ListBuffer.empty[Long]
        l ++= array
        for (i <- l.indices) {
            if (!found && l(i) > elem) {
                l.insert(i, elem)
                found = true
            }
        }
        l.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](5l.toLong, 4l.toLong, 3l.toLong, 2l.toLong, 1l.toLong, 0l.toLong)), (3l)).equals((List[Long](3l.toLong, 5l.toLong, 4l.toLong, 3l.toLong, 2l.toLong, 1l.toLong, 0l.toLong))));
    }

}
