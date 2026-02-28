import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[String] = {
        val just_ns = array.map(num => "n" * num.toInt)
        val final_output = ArrayBuffer[String]()
        for (wipe <- just_ns) {
            final_output += wipe
        }
        final_output.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[String]())));
    }

}
