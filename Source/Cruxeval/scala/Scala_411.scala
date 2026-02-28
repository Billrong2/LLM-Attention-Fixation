import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, pref : String) : Boolean = {
        if (pref.isInstanceOf[List[String]]) {
            return pref.asInstanceOf[List[String]].map(x => text.startsWith(x)).mkString(", ").toBoolean
        } else {
            return text.startsWith(pref)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("Hello World"), ("W")) == (false));
    }

}
