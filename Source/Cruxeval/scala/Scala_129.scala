import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, search_string : String) : List[Long] = {
        var indexes = ListBuffer[Long]()
        var mutableText = text
        while (mutableText.contains(search_string)) {
            indexes += mutableText.lastIndexOf(search_string)
            mutableText = mutableText.substring(0, mutableText.lastIndexOf(search_string))
        }
        indexes.toList
    }
    def main(args: Array[String]) = {
    assert(f(("ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ"), ("J")).equals((List[Long](28l.toLong, 19l.toLong, 12l.toLong, 6l.toLong))));
    }

}
