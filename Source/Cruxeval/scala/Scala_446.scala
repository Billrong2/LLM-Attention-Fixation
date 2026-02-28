import scala.math._
import scala.collection.mutable._

object Problem {
    def f(array : List[Long]) : List[Long] = {
        val l = array.length
        if (l % 2 == 0) {
            List()
        } else {
            array.reverse
        }
    }

    def check(candidate: List[Long] => List[Long]) = {
        assert(candidate(List(1, 2, 3)) == List(3, 2, 1))
    }

    def test_check() = {
        check(f)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long]())));
    }

}
