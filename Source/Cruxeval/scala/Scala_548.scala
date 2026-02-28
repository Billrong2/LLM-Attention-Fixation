import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : String = {
        if (suffix.nonEmpty && text.nonEmpty && text.endsWith(suffix)) {
            return text.stripSuffix(suffix)
        } else {
            return text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("spider"), ("ed")).equals(("spider")));
    }

}
