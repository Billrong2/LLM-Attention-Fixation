import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, chars : String) : String = {
        var listchars = chars.toList
        val first = listchars.head
        var mutableText = text
        for (i <- listchars.tail) {
            mutableText = mutableText.substring(0, mutableText.indexOf(i)) + i + mutableText.substring(mutableText.indexOf(i) + 1)
        }
        return mutableText
    }
    def main(args: Array[String]) = {
    assert(f(("tflb omn rtt"), ("m")).equals(("tflb omn rtt")));
    }

}
