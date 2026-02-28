import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String, code : String) : String = {
        var t = ""
        try {
            t = new String(string.getBytes(code), "UTF-8")
            if (t.endsWith("\n")) {
                t = t.substring(0, t.length - 1)
            }
            t
        } catch {
            case e: Exception => t
        }
    }
    def main(args: Array[String]) = {
    assert(f(("towaru"), ("UTF-8")).equals(("towaru")));
    }

}
