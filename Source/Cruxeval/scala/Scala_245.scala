import scala.collection.mutable.ListBuffer

object Problem {
    def f(alphabet : String, s : String) : List[String] = {
        var a = ListBuffer[String]()
        for (x <- alphabet if s.contains(x.toUpper)) {
            a += x.toString
        }
        if (s.toUpperCase == s) a += "all_uppercased"
        a.toList
    }
    def main(args: Array[String]) = {
    assert(f(("abcdefghijklmnopqrstuvwxyz"), ("uppercased # % ^ @ ! vz.")).equals((List[String]())));
    }

}
