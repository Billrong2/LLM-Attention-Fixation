import scala.math._
import scala.collection.mutable._
object Problem {
    def f(numbers : List[String], prefix : String) : List[String] = {
        numbers.map(n => if (n.length > prefix.length && n.startsWith(prefix)) n.substring(prefix.length) else n)
               .sorted
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("ix", "dxh", "snegi", "wiubvu")), ("")).equals((List[String]("dxh", "ix", "snegi", "wiubvu"))));
    }

}
