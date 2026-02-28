import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[String]) : List[String] = {
        if (nums.isEmpty) return nums
        val format = "%0" + nums.head + "d"
        nums.tail.map(num => format.format(num.toInt))
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("1", "2", "2", "44", "0", "7", "20257"))).equals((List[String]("2", "2", "44", "0", "7", "20257"))));
    }

}
