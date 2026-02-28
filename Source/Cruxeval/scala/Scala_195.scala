import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = text
        val prefixes = List("acs", "asp", "scn")
        for (p <- prefixes) {
            result = result.stripPrefix(p) + " "
        }
        result.stripPrefix(" ").dropRight(1)
    }
    def main(args: Array[String]) = {
    assert(f(("ilfdoirwirmtoibsac")).equals(("ilfdoirwirmtoibsac  ")));
    }

}
