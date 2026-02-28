import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], const : Long) : List[String] = {
        var output: ListBuffer[String] = ListBuffer("x")
        for (i <- 1 to array.length) {
            if (i % 2 != 0) {
                output += ((array(i - 1) * -2).toString)
            } else {
                output += const.toString
            }
        }
        output.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong)), (-1l)).equals((List[String]("x", "-2", "-1", "-6"))));
    }

}
