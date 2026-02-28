import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(lists: List[List[Long]]): List[Long] = {
        val mutableLists = lists.map(lst => ListBuffer(lst: _*))
        mutableLists(1).clear()
        mutableLists(2) ++= mutableLists(1)
        mutableLists(0).toList
    }
    def main(args: Array[String]) = {
    assert(f((List[List[Long]](List[Long](395l.toLong, 666l.toLong, 7l.toLong, 4l.toLong), List[Long](), List[Long](4223l.toLong, 111l.toLong)))).equals((List[Long](395l.toLong, 666l.toLong, 7l.toLong, 4l.toLong))));
    }

}
