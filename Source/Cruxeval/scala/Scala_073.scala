import scala.math._
import scala.collection.mutable._
object Problem {
    def f(row : String) : (Long, Long) = {
        (row.count(_ == '1'), row.count(_ == '0'))
    }
    def main(args: Array[String]) = {
    assert(f(("100010010")).equals(((3l, 6l))));
    }

}
