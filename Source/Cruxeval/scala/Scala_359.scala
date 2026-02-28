import scala.collection.mutable._
import scala.math._
object Problem {
    def f(lines: List[String]): List[String] = {
        val maxLength = lines.maxBy(_.length).length
        lines.map(line => line.padTo(maxLength, ' ').take(maxLength))
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("dZwbSR", "wijHeq", "qluVok", "dxjxbF"))).equals((List[String]("dZwbSR", "wijHeq", "qluVok", "dxjxbF"))));
    }

}
