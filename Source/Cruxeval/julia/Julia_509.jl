function f(value::Int64, width::Int64)::String 
    if value >= 0
        return string(value) |> x -> lpad(x, width, '0')
    elseif value < 0
        return '-' * string(-value) |> x -> lpad(x, width, '0')
    else
        return ""
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate(5, 1) == "5")
end
