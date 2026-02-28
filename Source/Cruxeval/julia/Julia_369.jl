function f(var::String)::String 
    if occursin(r"^\d+$", var)
        return "int"
    elseif occursin(r"^\d+\.\d+$", var)
        return "float"
    elseif count(isspace, var) == length(var) - 1
        return "str"
    elseif length(var) == 1
        return "char"
    else
        return "tuple"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate(" 99 777") == "tuple")
end
