import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : Long) : Any = {
        if (a == 0) {
            return List(0)
        }
        var result : List[Long] = List()
        var num = a
        while (num > 0) {
            result = num%10 :: result
            num = num/10
        }
        result.mkString("").toLong
    }
    def main(args: Array[String]) = {
    assert(f((0l)).equals(List[Long](0l.toLong)));
    }

}
