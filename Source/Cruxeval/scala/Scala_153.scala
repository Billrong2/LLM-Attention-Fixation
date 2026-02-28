import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String, num : Long) : Boolean = {
        val str_num = num.toString
        text.endsWith(suffix + str_num)
    }
    def main(args: Array[String]) = {
    assert(f(("friends and love"), ("and"), (3l)) == (false));
    }

}
