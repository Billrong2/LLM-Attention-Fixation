import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], index : Long) : Long = {
        if (index < 0){
            f(array, array.length + index)
        } else {
            array(index.toInt)
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong)), (0l)) == (1l));
    }

}
