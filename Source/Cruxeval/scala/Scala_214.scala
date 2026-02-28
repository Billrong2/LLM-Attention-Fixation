import scala.math._
import scala.collection.mutable._
object Problem {
    def f(sample : String) : Long = {
        var i = -1
        while (sample.indexOf('/', i+1) != -1) {
            i = sample.indexOf('/', i+1)
        }
        sample.substring(0, i).lastIndexOf('/')
    }
    def main(args: Array[String]) = {
    assert(f(("present/here/car%2Fwe")) == (7l));
    }

}
