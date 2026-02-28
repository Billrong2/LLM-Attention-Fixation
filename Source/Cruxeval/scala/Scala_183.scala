import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : List[String] = {
        val ls = text.split(" ").toList
        var lines = ls.grouped(3).flatMap(_.headOption).toList
        var res = List[String]()
        for (i <- 0 until 2) {
            val ln = ls.grouped(3).flatMap(_.tail.headOption).toList
            if (3 * i + 1 < ln.length) {
                res = res :+ ln.slice(3 * i, 3 * (i + 1)).mkString(" ")
            }
        }
        lines ++ res
    }
    def main(args: Array[String]) = {
    assert(f(("echo hello!!! nice!")).equals((List[String]("echo"))));
    }

}
