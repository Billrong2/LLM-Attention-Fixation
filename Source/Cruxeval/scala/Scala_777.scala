import scala.math._
import scala.collection.mutable._
object Problem {
    def f(names : List[String], excluded : String) : List[String] = {
        var updatedNames = names.map { name =>
            if (name.contains(excluded)) {
                name.replace(excluded, "")
            } else {
                name
            }
        }
        updatedNames
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("avc  a .d e")), ("")).equals((List[String]("avc  a .d e"))));
    }

}
