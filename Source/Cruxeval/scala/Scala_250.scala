import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var count = text.length
        var result = text
        for (i <- -count + 1 until 0){
            result = result + result(result.length + i)
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("wlace A")).equals(("wlace Alc l  ")));
    }

}
