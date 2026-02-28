import scala.math._
import scala.collection.mutable._
object Problem {
    def f(url : String) : String = {
        url.stripPrefix("http://www.")
    }
    def main(args: Array[String]) = {
    assert(f(("https://www.www.ekapusta.com/image/url")).equals(("https://www.www.ekapusta.com/image/url")));
    }

}
