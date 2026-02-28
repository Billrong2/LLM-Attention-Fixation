import scala.math._
import scala.collection.mutable._
object Problem {
    def f(values : List[Long], item1 : Long, item2 : Long) : List[Long] = {
        if (values.last == item2) {
            if (!values.tail.contains(values.head)) {
                values :+ values.head
            }
        } else if (values.last == item1) {
            if (values.head == item2) {
                values :+ values.head
            }
        }
        values
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong)), (2l), (3l)).equals((List[Long](1l.toLong, 1l.toLong))));
    }

}
