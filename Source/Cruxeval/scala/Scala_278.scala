import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array1 : List[Long], array2 : List[Long]) : Map[Long,List[Long]] = {
        var result = Map[Long,List[Long]]()
        for (key <- array1) {
            result += (key -> array2.filter(el => key * 2 > el))
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 132l.toLong)), (List[Long](5l.toLong, 991l.toLong, 32l.toLong, 997l.toLong))).equals((Map[Long,List[Long]](0l -> List[Long](), 132l -> List[Long](5l.toLong, 32l.toLong)))));
    }

}
