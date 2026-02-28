import scala.math._
import scala.collection.mutable._
object Problem {
    def f(replace : String, text : String, hide : String) : String = {
        var tempReplace = replace
        var tempText = text
        while (tempText.contains(hide)) {
            tempReplace += "ax"
            tempText = tempText.replaceFirst(hide, tempReplace)
        }
        tempText
    }
    def main(args: Array[String]) = {
    assert(f(("###"), ("ph>t#A#BiEcDefW#ON#iiNCU"), (".")).equals(("ph>t#A#BiEcDefW#ON#iiNCU")));
    }

}
