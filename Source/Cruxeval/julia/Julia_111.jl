function f(marks::Dict{String, Int})::Tuple{Int, Int}
    highest = 0
    lowest = 100
    for value in values(marks)
        if value > highest
            highest = value
        end
        if value < lowest
            lowest = value
        end
    end
    return (highest, lowest)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("x" => 67, "v" => 89, "" => 4, "alij" => 11, "kgfsd" => 72, "yafby" => 83)) == (89, 4))
end
