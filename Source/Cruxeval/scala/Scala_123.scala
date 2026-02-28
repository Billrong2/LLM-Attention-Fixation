import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(array: List[Long], elem: Long): List[Long] = {
        val buffer = ListBuffer[Long]() ++ array
        var index = 0
        while (index < buffer.length) {
            if (buffer(index) > elem && buffer(index - 1) < elem) {
                buffer.insert(index, elem)
            }
            index += 1
        }
        buffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 5l.toLong, 8l.toLong)), (6l)).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 5l.toLong, 6l.toLong, 8l.toLong))));
    }

}
