function f(name::String)::String 
    return "| " * join(split(name, ' '), " ") * " |"
end
using Test

@testset begin

candidate = f;
	@test(candidate("i am your father") == "| i am your father |")
end
