import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, size : Long) : String = {
        var mutableText = text
        var counter = text.length
        for (i <- 0 until (size - size.toInt % 2).toInt) {
            mutableText = " " + mutableText + " "
            counter += 2
            if (counter >= size) {
                return mutableText
            }
        }
        mutableText
    }
    def main(args: Array[String]) = {
    assert(f(("7"), (10l)).equals(("     7     ")));
    }

}
