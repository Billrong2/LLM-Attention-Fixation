import scala.math._
import scala.collection.mutable._
object Problem {
    def f(simpons : List[String]) : String = {
        var simponsMutable = simpons.toBuffer
        var pop: String = ""
        while (simponsMutable.nonEmpty) {
            pop = simponsMutable.remove(simponsMutable.size - 1)
            if (pop == pop.capitalize) {
                return pop
            }
        }
        pop
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("George", "Michael", "George", "Costanza"))).equals(("Costanza")));
    }

}
