import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long], mos: List[Long]): Boolean = {
        var modifiedNums = nums.filterNot(mos.contains)
        modifiedNums = modifiedNums.sorted
        modifiedNums = modifiedNums ++ mos
        for (i <- 0 until modifiedNums.length - 1) {
            if (modifiedNums(i) > modifiedNums(i + 1)) {
                return false
            }
        }
        true
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 1l.toLong, 2l.toLong, 1l.toLong, 4l.toLong, 1l.toLong)), (List[Long](1l.toLong))) == (false));
    }

}
