import scala.math._
import scala.collection.mutable._
import scala.collection.JavaConverters._

object Problem {
    def f(text : String, chunks : Long) : List[String] = {
        val lines = text.split("\n")
        val chunkSize = if (lines.length <= chunks || chunks == 0) 1 else lines.length / chunks.asInstanceOf[Int]
        lines.grouped(chunkSize).toList.map(_.mkString("\n"))
    }
    def main(args: Array[String]) = {
    assert(f(("/alcm@ an)t//eprw)/e!/d\nujv"), (0l)).equals((List[String]("/alcm@ an)t//eprw)/e!/d", "ujv"))));
    }

}
