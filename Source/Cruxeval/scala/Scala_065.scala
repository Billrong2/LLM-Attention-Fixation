import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], index : Long) : Long = {
        val newNums = nums.toBuffer
        val result = newNums(index.toInt) % 42 + newNums.remove(index.toInt) * 2
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 2l.toLong, 0l.toLong, 3l.toLong, 7l.toLong)), (3l)) == (9l));
    }

}
