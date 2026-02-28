import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : Boolean = {
        val updatedSuffix = if (suffix == "") None else Some(suffix)
        text.endsWith(updatedSuffix.getOrElse(""))
    }
    def main(args: Array[String]) = {
    assert(f(("uMeGndkGh"), ("kG")) == (false));
    }

}
