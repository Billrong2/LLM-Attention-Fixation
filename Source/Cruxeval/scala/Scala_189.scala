import scala.math._
import scala.collection.mutable._
object Problem {
    def f(out : String, mapping : Map[String,List[String]]) : String = {
        mapping.values.foreach {
            case List(_, second) => out.format(second.reverse)
            case _ =>
        }
        out
    }
    def main(args: Array[String]) = {
    assert(f(("{{{{}}}}"), (Map[String,List[String]]())).equals(("{{{{}}}}")));
    }

}
