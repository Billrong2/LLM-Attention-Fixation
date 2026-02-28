import scala.math._
import scala.collection.mutable._
object Problem {
    def f(names : List[String]) : Long = {
        val count = names.length
        var numberOfNames = 0
        for (name <- names) {
            if (name.forall(_.isLetter)) {
                numberOfNames += 1
            }
        }
        numberOfNames
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("sharron", "Savannah", "Mike Cherokee"))) == (2l));
    }

}
