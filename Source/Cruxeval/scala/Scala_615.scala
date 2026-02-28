import scala.math._
import scala.collection.mutable._
object Problem {
    def f(in_list : List[Long], num : Long) : Long = {
        in_list :+ num
        in_list.indexOf(in_list.init.max)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-1l.toLong, 12l.toLong, -6l.toLong, -2l.toLong)), (-1l)) == (1l));
    }

}
