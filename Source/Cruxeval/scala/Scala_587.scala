import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], fill : String) : Map[Long,String] = {
        var ans = Map[Long, String]()
        for (num <- nums) {
            ans += (num -> fill)
        }
        ans
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 1l.toLong, 1l.toLong, 2l.toLong)), ("abcca")).equals((Map[Long,String](0l -> "abcca", 1l -> "abcca", 2l -> "abcca"))));
    }

}
