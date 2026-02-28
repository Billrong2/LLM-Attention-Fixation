import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val new_text = text.map(c => c.toUpper)
        new_text.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("dst vavf n dmv dfvm gamcu dgcvb.")).equals(("DST VAVF N DMV DFVM GAMCU DGCVB.")));
    }

}
