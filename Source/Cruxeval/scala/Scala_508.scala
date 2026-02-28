import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, sep : String, maxsplit : Long) : String = {
        val splitted = text.split(sep, maxsplit.toInt)
        val length = splitted.length
        val newSplitted = splitted.take(length / 2).reverse ++ splitted.drop(length / 2)
        newSplitted.mkString(sep)
    }
    def main(args: Array[String]) = {
    assert(f(("ertubwi"), ("p"), (5l)).equals(("ertubwi")));
    }

}
