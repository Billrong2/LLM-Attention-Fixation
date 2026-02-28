import scala.math._
import scala.collection.mutable._
object Problem {
    def f(L : List[Long]) : List[Long] = {
        var list = L.toArray
        val N = L.length
        for (k <- 1 to N/2) {
            var i = k - 1
            var j = N - k
            while (i < j) {
                // swap elements:
                val temp = list(i)
                list(i) = list(j)
                list(j) = temp
                // update i, j:
                i += 1
                j -= 1
            }
        }
        list.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](16l.toLong, 14l.toLong, 12l.toLong, 7l.toLong, 9l.toLong, 11l.toLong))).equals((List[Long](11l.toLong, 14l.toLong, 7l.toLong, 12l.toLong, 9l.toLong, 16l.toLong))));
    }

}
