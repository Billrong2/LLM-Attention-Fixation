import scala.math._
import scala.collection.mutable._
object Problem {
    def f(forest : String, animal : String) : String = {
        val index = forest.indexOf(animal)
        var result = forest.toCharArray
        var i = index
        while (i < forest.length - 1) {
            result(i) = forest(i + 1)
            i += 1
        }
        if (i == forest.length - 1) {
            result(i) = '-'
        }
        result.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("2imo 12 tfiqr."), ("m")).equals(("2io 12 tfiqr.-")));
    }

}
