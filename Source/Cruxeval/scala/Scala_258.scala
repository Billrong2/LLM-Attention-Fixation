import scala.math._
import scala.collection.mutable._
object Problem {
    def f(L : List[Long], m : Long, start : Long, step : Long) : List[Long] = {
        val listBuffer = L.to[ListBuffer]
        listBuffer.insert(start.toInt, m)
        var index = listBuffer.indexOf(m)
        var s = start
        for (x <- (start-1) to 0 by -step.toInt) {
            s -= 1
            val temp = listBuffer.remove(index - 1)
            listBuffer.insert(s.toInt, temp)
            index -= 1
        }
        listBuffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 7l.toLong, 9l.toLong)), (3l), (3l), (2l)).equals((List[Long](1l.toLong, 2l.toLong, 7l.toLong, 3l.toLong, 9l.toLong))));
    }

}
