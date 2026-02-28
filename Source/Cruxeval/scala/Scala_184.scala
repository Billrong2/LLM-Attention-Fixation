import scala.math._
import scala.collection.mutable._
object Problem {
    def f(digits : List[Long]) : List[Long] = {
        digits.reverse match {
            case list if list.length < 2 => list
            case list => (0 until list.length by 2).foldLeft(list){
                case (l, i) => l.updated(i, list(i+1)).updated(i+1, list(i))
            }
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong))).equals((List[Long](1l.toLong, 2l.toLong))));
    }

}
