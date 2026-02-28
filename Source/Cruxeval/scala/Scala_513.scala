import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
        var newList = array
        while(newList.contains(-1)){
            newList = newList.dropRight(3)
        }
        while(newList.contains(0)){
            newList = newList.dropRight(1)
        }
        while(newList.contains(1)){
            newList = newList.drop(1)
        }
        newList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 2l.toLong))).equals((List[Long]())));
    }

}
