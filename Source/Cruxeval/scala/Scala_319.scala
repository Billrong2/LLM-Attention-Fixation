import scala.math._
import scala.collection.mutable._
object Problem {
    def f(needle : String, haystack : String) : Long = {
        var count = 0
        var updatedHaystack = haystack

        while (updatedHaystack.contains(needle)) {
            updatedHaystack = updatedHaystack.replaceFirst(needle, "")
            count += 1
        }
        
        count
    }
    def main(args: Array[String]) = {
    assert(f(("a"), ("xxxaaxaaxx")) == (4l));
    }

}
