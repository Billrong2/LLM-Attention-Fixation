import scala.math._
import scala.collection.mutable._
object Problem {
    def f(album_sales : List[Long]) : Long = {
        var sales = album_sales
        while (sales.length != 1) {
            sales = sales.tail :+ sales.head
        }
        sales.head
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong))) == (6l));
    }

}
