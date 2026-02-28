import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, lower : Long, upper : Long) : Boolean = {
        text.substring(lower.toInt, upper.toInt).forall(_.isValidByte)
    }
    def main(args: Array[String]) = {
    assert(f(("=xtanp|sugv?z"), (3l), (6l)) == (true));
    }

}
