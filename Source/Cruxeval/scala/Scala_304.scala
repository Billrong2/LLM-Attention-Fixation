import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[Long,Long]) : Map[Long,Long] = {
        val sortedItems = d.toList.sortBy(-_._1)
        val key1 = sortedItems.head._1
        val val1 = d(key1)
        val filteredMap1 = d - key1

        val key2 = filteredMap1.toList.sortBy(-_._1).head._1
        val val2 = filteredMap1(key2)

        Map(key1 -> val1, key2 -> val2)
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](2l -> 3l, 17l -> 3l, 16l -> 6l, 18l -> 6l, 87l -> 7l))).equals((Map[Long,Long](87l -> 7l, 18l -> 6l))));
    }

}
