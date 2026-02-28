import scala.math._
import scala.collection.mutable._
object Problem {
    def f(years : List[Long]) : Long = {
        val a10 = years.count(_ <= 1900)
        val a90 = years.count(_ > 1910)
        
        if (a10 > 3) {
            3
        } else if (a90 > 3) {
            1
        } else {
            2
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1872l.toLong, 1995l.toLong, 1945l.toLong))) == (2l));
    }

}
