import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        var indexes = ListBuffer[Int]()
        for (i <- 0 until text.length) {
            if (text(i).toString == value && (i == 0 || text(i-1).toString != value)) {
                indexes += i
            }
        }
        if (indexes.length % 2 == 1) {
            return text
        }
        return text.substring(indexes(0) + 1, indexes(indexes.length - 1))
    }
    def main(args: Array[String]) = {
    assert(f(("btrburger"), ("b")).equals(("tr")));
    }

}
