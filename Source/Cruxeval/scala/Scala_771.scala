import scala.math._
import scala.collection.mutable._
object Problem {
    def f(items : List[Long]) : List[Long] = {
        var odd_positioned = ListBuffer[Long]()
        val mutable_items = items.toBuffer
        while (mutable_items.length > 0) {
            val position = mutable_items.indexOf(mutable_items.min)
            mutable_items.remove(position)
            val item = mutable_items.remove(position)
            odd_positioned += item
        }
        odd_positioned.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong, 5l.toLong, 6l.toLong, 7l.toLong, 8l.toLong))).equals((List[Long](2l.toLong, 4l.toLong, 6l.toLong, 8l.toLong))));
    }

}
