import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, function : String) : List[Long] = {
        var cites = List(text.indexOf(function) + function.length)

        for (char <- text) {
            if (char.toString == function) {
                cites :+= text.indexOf(function, cites.last) + function.length
            }
        }

        cites.map(_.toLong)
    }
    def main(args: Array[String]) = {
    assert(f(("010100"), ("010")).equals((List[Long](3l.toLong))));
    }

}
