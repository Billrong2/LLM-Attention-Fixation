function f(text::String)::String
    result = IOBuffer()
    for i in eachindex(text)
        if isspace(text[i])
            print(result, "&nbsp;")
        else
            print(result, text[i])
        end
    end
    return String(take!(result))
end

using Test

@testset begin

candidate = f;
	@test(candidate("   ") == "&nbsp;&nbsp;&nbsp;")
end
