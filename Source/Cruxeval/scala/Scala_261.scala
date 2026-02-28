import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], target : Long) : Tuple2[List[Long], List[Long]] = {
        var lows = List[Long]()
        var higgs = List[Long]()
        
        for (i <- nums) {
            if (i < target) {
                lows = lows :+ i
            } else {
                higgs = higgs :+ i
            }
        }
        
        lows = List[Long]()
        (lows, higgs)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](12l.toLong, 516l.toLong, 5l.toLong, 2l.toLong, 3l.toLong, 214l.toLong, 51l.toLong)), (5l)).equals(((List[Long](), List[Long](12l.toLong, 516l.toLong, 5l.toLong, 214l.toLong, 51l.toLong)))));
    }

}
