import scala.math._
import scala.collection.mutable._
object Problem {
    def f(item : String) : String = {
        val modified = item.replace(". ", " , ").replace("&#33; ", "! ").replace(". ", "? ").replace(". ", ". ")
        modified.charAt(0).toUpper + modified.substring(1)
    }
    def main(args: Array[String]) = {
    assert(f((".,,,,,. منبت")).equals((".,,,,, , منبت")));
    }

}
