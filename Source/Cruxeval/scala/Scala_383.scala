import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, chars : String) : String = {
        var result = text.toList
        while (result.takeRight(3).sliding(2, 2).exists(_.mkString == chars)) {
            result = result.filterNot(_ == result.takeRight(3)(0))
            result = result.filterNot(_ == result.takeRight(3)(0))
        }
        result.mkString("").stripSuffix(".")
    }
    def main(args: Array[String]) = {
    assert(f(("ellod!p.nkyp.exa.bi.y.hain"), (".n.in.ha.y")).equals(("ellod!p.nkyp.exa.bi.y.hain")));
    }

}
