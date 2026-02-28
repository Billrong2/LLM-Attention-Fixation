import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val arr = text.split(" ")
        var result = ListBuffer[String]()
        
        for (item <- arr) {
            if (item.endsWith("day")) {
                result += item + "y"
            } else {
                result += item + "day"
            }
        }
        
        result.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("nwv mef ofme bdryl")).equals(("nwvday mefday ofmeday bdrylday")));
    }

}
