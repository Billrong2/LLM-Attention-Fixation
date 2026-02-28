import scala.collection.mutable._
import scala.math._
object Problem {
    def f(names: List[String]): String = {
        if (names.isEmpty) {
            return ""
        }
        val smallest = names.min
        val updatedNames = names.filterNot(_ == smallest)
        smallest
    }
    def main(args: Array[String]) = {
    assert(f((List[String]())).equals(("")));
    }

}
