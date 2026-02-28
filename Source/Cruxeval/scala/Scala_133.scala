import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], elements : List[Long]) : List[Long] = {
        // In Python, pop() removes the last element of the list.
        // So, we will just return the remaining part of the list.
        nums.take(nums.length - elements.length)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](7l.toLong, 1l.toLong, 2l.toLong, 6l.toLong, 0l.toLong, 2l.toLong)), (List[Long](9l.toLong, 0l.toLong, 3l.toLong))).equals((List[Long](7l.toLong, 1l.toLong, 2l.toLong))));
    }

}
