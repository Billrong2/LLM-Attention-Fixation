import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String) : String = {
        var t = text
        var mutableText = text
        for (i <- text) {
            mutableText = mutableText.replace(i.toString, "")
        }
        return mutableText.length.toString + t
    }
    def main(args: Array[String]) = {
    assert(f(("ThisIsSoAtrocious")).equals(("0ThisIsSoAtrocious")));
    }

}
