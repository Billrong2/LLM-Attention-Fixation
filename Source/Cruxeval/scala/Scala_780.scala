import scala.math._
import scala.collection.mutable._
object Problem {
    def f(ints : List[Long]) : String = {
        var counts = Array.fill(301)(0)
        
        for (i <- ints) {
            counts(i.toInt) += 1
        }
        
        var r = ListBuffer[String]()
        for (i <- counts.indices) {
            if (counts(i) >= 3) {
                r += i.toString
            }
        }
        
        counts = Array.fill(301)(0)
        r.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong, 3l.toLong, 5l.toLong, 2l.toLong, 4l.toLong, 5l.toLong, 2l.toLong, 89l.toLong))).equals(("2")));
    }

}
