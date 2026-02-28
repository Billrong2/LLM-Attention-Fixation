function f(concat::String, di::Dict{String, String})::String 
    count = length(di)
    for i in 0:count-1
        if haskey(di, string(i)) && string(i) in keys(di)
            pop!(di, string(i))
        end
    end
    return "Done!"
end
using Test

@testset begin

candidate = f;
	@test(candidate("mid", Dict("0" => "q", "1" => "f", "2" => "w", "3" => "i")) == "Done!")
end
