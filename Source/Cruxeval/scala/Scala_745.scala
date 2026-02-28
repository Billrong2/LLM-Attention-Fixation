import scala.collection.mutable._
import scala.math._
object Problem {
    def f(address : String) : String = {
        var mutableAddress = address
        val suffix_start = mutableAddress.indexOf('@') + 1
        if (mutableAddress.substring(suffix_start).count(_ == '.') > 1) {
            mutableAddress = mutableAddress.reverse.replaceFirst(mutableAddress.split('@')(1).split('.').take(2).mkString(".").reverse, "").reverse
        }
        mutableAddress
    }
    def main(args: Array[String]) = {
    assert(f(("minimc@minimc.io")).equals(("minimc@minimc.io")));
    }

}
