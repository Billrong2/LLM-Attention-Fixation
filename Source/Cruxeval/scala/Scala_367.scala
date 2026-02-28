import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], rmvalue : Long) : List[Long] = {
        var res = nums.toList
        while (res.contains(rmvalue)) {
            val index = res.indexOf(rmvalue)
            val popped = res(index)
            res = res.patch(index, Nil, 1)
            if (popped != rmvalue) {
                res = res :+ popped
            }
        }
        res
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong, 2l.toLong, 1l.toLong, 1l.toLong, 4l.toLong, 1l.toLong)), (5l)).equals((List[Long](6l.toLong, 2l.toLong, 1l.toLong, 1l.toLong, 4l.toLong, 1l.toLong))));
    }

}
