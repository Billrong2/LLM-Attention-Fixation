import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var rtext = text.toList
        for (i <- 1 until rtext.length - 1) {
            rtext = rtext.take(i + 1) ::: List('|') ::: rtext.drop(i + 1)
        }
        rtext.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("pxcznyf")).equals(("px|||||cznyf")));
    }

}
