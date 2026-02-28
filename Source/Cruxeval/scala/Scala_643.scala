import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String, suffix: String): String = {
        var modifiedText = text
        if (text.endsWith(suffix)) {
            modifiedText = text.dropRight(1) + text.takeRight(1).toUpperCase
        }
        modifiedText
    }
    def main(args: Array[String]) = {
    assert(f(("damdrodm"), ("m")).equals(("damdrodM")));
    }

}
