import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : String = {
        var result = text + suffix
        while (result.takeRight(suffix.length) == suffix) {
            result = result.dropRight(1)
        }
        return result
    }
    def main(args: Array[String]) = {
    assert(f(("faqo osax f"), ("f")).equals(("faqo osax ")));
    }

}
