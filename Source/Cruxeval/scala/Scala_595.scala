import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, prefix : String) : String = {
        var result = text
        if (text.startsWith(prefix)) {
            result = text.stripPrefix(prefix)
        }
        result.capitalize
    }
    def main(args: Array[String]) = {
    assert(f(("qdhstudentamxupuihbuztn"), ("jdm")).equals(("Qdhstudentamxupuihbuztn")));
    }

}
