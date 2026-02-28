import scala.math._
import scala.collection.mutable._
object Problem {
    def f(postcode : String) : String = {
        return postcode.substring(postcode.indexOf('C'))
    }
    def main(args: Array[String]) = {
    assert(f(("ED20 CW")).equals(("CW")));
    }

}
