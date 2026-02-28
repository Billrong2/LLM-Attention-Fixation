function f(txt::Vector{String}, alpha::String)::Vector{String} 
    txt = sort(txt)
    if findfirst(x -> x == alpha, txt) % 2 != 0
        return reverse(txt)
    end
    return txt
end
using Test

@testset begin

candidate = f;
	@test(candidate(["8", "9", "7", "4", "3", "2"], "9") == ["2", "3", "4", "7", "8", "9"])
end
