import scala.math._
import scala.collection.mutable._
object Problem {
    def f(chemicals : List[String], num : Long) : List[String] = {
        val fish = chemicals.drop(1)
        var revChemicals = chemicals.reverse
        for (i <- 0L until num) {
            fish.+:(revChemicals.apply(1))
            revChemicals = revChemicals.drop(1)
        }
        revChemicals.reverse
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("lsi", "s", "t", "t", "d")), (0l)).equals((List[String]("lsi", "s", "t", "t", "d"))));
    }

}
