import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val textList = text.split(",").toList
        val indexT = textList.indexOf("T")
        val newTextList = textList.updated(0, textList(indexT)).patch(indexT, Nil, 1)
        "T," + newTextList.mkString(",")
    }
    def main(args: Array[String]) = {
    assert(f(("Dmreh,Sspp,T,G ,.tB,Vxk,Cct")).equals(("T,T,Sspp,G ,.tB,Vxk,Cct")));
    }

}
