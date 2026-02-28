import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, search : String) : Long = {
        val result = text.toLowerCase()
        result.indexOf(search.toLowerCase())
    }
    def main(args: Array[String]) = {
    assert(f(("car hat"), ("car")) == (0l));
    }

}
