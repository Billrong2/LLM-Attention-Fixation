import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], pos : Long) : List[Long] = {
        if (pos % 2 == 1) {
            nums.take(nums.size - 1).reverse ::: nums.drop(nums.size - 1)
        } else {
            nums.reverse
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong, 1l.toLong)), (3l)).equals((List[Long](6l.toLong, 1l.toLong))));
    }

}
