function f(s::String)::String 
    return uppercase(s)
end
using Test

@testset begin

candidate = f;
	@test(candidate("Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1") == "JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1")
end
