import scala.math._
import scala.collection.mutable._
object Problem {
    def f(numbers : List[String], num : Long, val_ : Long) : String = {
        var numbers_ = numbers
        while (numbers_.length < num) {
            numbers_ = numbers_.updated(numbers_.length / 2, val_.toString)
        }
        for (_ <- 0L until numbers_.length / (num - 1) - 4) {
            numbers_ = numbers_.updated(numbers_.length / 2, val_.toString)
        }
        numbers_.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f((List[String]()), (0l), (1l)).equals(("")));
    }

}
