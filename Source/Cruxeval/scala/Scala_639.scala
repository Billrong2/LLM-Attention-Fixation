import scala.math._
import scala.collection.mutable._
object Problem {
    def f(perc : String, full : String) : String = {
        var reply = ""
        var i = 0
        while (i < full.length && i < perc.length && perc.charAt(i) == full.charAt(i)) {
            if (perc.charAt(i) == full.charAt(i)) {
                reply += "yes "
            } else {
                reply += "no "
            }
            i += 1
        }
        reply
    }
    def main(args: Array[String]) = {
    assert(f(("xabxfiwoexahxaxbxs"), ("xbabcabccb")).equals(("yes ")));
    }

}
