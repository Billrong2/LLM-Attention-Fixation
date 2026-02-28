function f(stg::String, tabs::Vector{String})::String
    for tab in tabs
        for char in tab
            stg = rstrip(stg, char)
        end
    end
    return stg
end

using Test

@testset begin

candidate = f;
	@test(candidate("31849 let it!31849 pass!", ["3", "1", "8", " ", "1", "9", "2", "d"]) == "31849 let it!31849 pass!")
end
