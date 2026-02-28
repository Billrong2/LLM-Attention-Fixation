import scala.collection.mutable._

object Problem {
    def f(text : String) : List[List[String]] = {
        var created = ListBuffer[ListBuffer[String]]()
        text.split("\n").foreach(line => {
            if (line != "") {
                val line_split = line.reverse.split("")
                if (line_split(0) != "") {
                    created += ListBuffer(line_split(0))
                }
            } else {
                return created.toList.reverse.map(_.toList)
            }
        })
        created.toList.reverse.map(_.toList)
    }
    def main(args: Array[String]) = {
    assert(f(("A(hiccup)A")).equals((List[List[String]](List[String]("A")))));
    }

}
