import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dct : Map[String,String]) : Map[String,String] = {
        val values = dct.values
        var result = Map[String, String]()
        for (value <- values) {
            val item = value.split("\\.")(0) + "@pinc.uk"
            result += (value -> item)
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]())).equals((Map[String,String]())));
    }

}
