import scala.math._
import scala.collection.mutable._
object Problem {
    def f(strings : List[String], substr : String) : List[String] = {
        val list = strings.filter(s => s.startsWith(substr))
        list.sortBy(_.length)
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("condor", "eyes", "gay", "isa")), ("d")).equals((List[String]())));
    }

}
