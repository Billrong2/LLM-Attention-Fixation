import scala.math._
import scala.collection.mutable._
object Problem {
    def f(char_map : Map[String,String], text : String) : String = {
        var new_text = ""
        text.foreach { ch =>
            val valOpt = char_map.get(ch.toString)
            val newChar = valOpt match {
                case Some(value) => value
                case None => ch.toString
            }
            new_text += newChar
        }
        new_text
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]()), ("hbd")).equals(("hbd")));
    }

}
