import scala.math._
import scala.collection.mutable._
object Problem {
    def f(matr : List[List[Long]], insert_loc : Long) : List[List[Long]] = {
        val newMatr = matr.take(insert_loc.toInt) ::: List(List()) ::: matr.drop(insert_loc.toInt)
        newMatr
    }
    def main(args: Array[String]) = {
    assert(f((List[List[Long]](List[Long](5l.toLong, 6l.toLong, 2l.toLong, 3l.toLong), List[Long](1l.toLong, 9l.toLong, 5l.toLong, 6l.toLong))), (0l)).equals((List[List[Long]](List[Long](), List[Long](5l.toLong, 6l.toLong, 2l.toLong, 3l.toLong), List[Long](1l.toLong, 9l.toLong, 5l.toLong, 6l.toLong)))));
    }

}
