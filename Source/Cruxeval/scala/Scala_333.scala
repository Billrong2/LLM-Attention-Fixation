import scala.collection.mutable._
import scala.math._
object Problem {
    def f(places: List[Long], lazyList: List[Long]): Long = {
        var sortedPlaces = places.sorted
        for (l <- lazyList) {
            sortedPlaces = sortedPlaces.filter(_ != l)
        }
        if (sortedPlaces.length == 1) {
            return 1
        }
        for ((place, i) <- sortedPlaces.zipWithIndex) {
            if (!sortedPlaces.contains(place + 1)) {
                return i + 1
            }
        }
        sortedPlaces.length + 1
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](375l.toLong, 564l.toLong, 857l.toLong, 90l.toLong, 728l.toLong, 92l.toLong)), (List[Long](728l.toLong))) == (1l));
    }

}
