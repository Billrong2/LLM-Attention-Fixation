function f(text::String)::String 
    arr = split(text)
    result = []
    for item in arr
        if endswith(item, "day")
            item *= "y"
        else
            item *= "day"
        end
        push!(result, item)
    end
    return join(result, " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("nwv mef ofme bdryl") == "nwvday mefday ofmeday bdrylday")
end
