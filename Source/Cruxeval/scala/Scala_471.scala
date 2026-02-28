import scala.collection.mutable._
import scala.math._
object Problem {
    def f(value: String, text: String): Long = {
        val indices = text.zipWithIndex.filter(_._1.toString == value).map(_._2)
        if (indices.isEmpty) {
            -1
        } else {
            indices.head
        }
    }
    def main(args: Array[String]) = {
    assert(f(("o"), ("fnmart")) == (-1l));
    }

}
