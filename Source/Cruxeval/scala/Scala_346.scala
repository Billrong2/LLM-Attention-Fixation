import scala.math._
import scala.collection.mutable._
object Problem {
    def f(filename : String) : Boolean = {
        val suffix = filename.split('.').last
        val f2 = filename + suffix.reverse
        f2.endsWith(suffix)
    }
    def main(args: Array[String]) = {
    assert(f(("docs.doc")) == (false));
    }

}
