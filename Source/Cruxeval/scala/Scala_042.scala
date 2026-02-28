import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        var newNums = nums
        newNums = newNums.filter(_ => false)
        for (num <- newNums) {
            newNums :+= num*2
        }
        newNums
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](4l.toLong, 3l.toLong, 2l.toLong, 1l.toLong, 2l.toLong, -1l.toLong, 4l.toLong, 2l.toLong))).equals((List[Long]())));
    }

}
