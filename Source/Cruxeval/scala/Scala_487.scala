import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dict : Map[Long,String]) : List[Long] = {
        var evenKeys = ListBuffer[Long]()
        
        for ((key, _) <- dict) {
            if (key % 2 == 0) {
                evenKeys += key
            }
        }
        
        evenKeys.toList
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,String](4l -> "a"))).equals((List[Long](4l.toLong))));
    }

}
