import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, splitter : String) : String = {
        return text.toLowerCase.split(" ").mkString(splitter)
    }
    def main(args: Array[String]) = {
    assert(f(("LlTHH sAfLAPkPhtsWP"), ("#")).equals(("llthh#saflapkphtswp")));
    }

}
