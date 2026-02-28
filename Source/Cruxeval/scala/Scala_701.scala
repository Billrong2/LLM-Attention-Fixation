import scala.math._
import scala.collection.mutable._
object Problem {
    def f(stg : String, tabs : List[String]) : String = {
        var newString = stg
        for (tab <- tabs) {
            newString = newString.stripSuffix(tab)
        }
        newString
    }
    def main(args: Array[String]) = {
    assert(f(("31849 let it!31849 pass!"), (List[String]("3", "1", "8", " ", "1", "9", "2", "d"))).equals(("31849 let it!31849 pass!")));
    }

}
