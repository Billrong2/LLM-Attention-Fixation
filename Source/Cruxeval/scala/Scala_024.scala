import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], i : Long) : List[Long] = {
        nums.patch(i.toInt, Nil, 1)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](35l.toLong, 45l.toLong, 3l.toLong, 61l.toLong, 39l.toLong, 27l.toLong, 47l.toLong)), (0l)).equals((List[Long](45l.toLong, 3l.toLong, 61l.toLong, 39l.toLong, 27l.toLong, 47l.toLong))));
    }

}
