function f(text::String, changes::String)::String 
    result = ""
    count = 0
    changes = collect(changes)
    for char in text
        if char in "e"
            result *= char
        else
            result *= changes[count % length(changes) + 1]
        end
        count += (char ∉ "e") ? 1 : 0
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("fssnvd", "yes") == "yesyes")
end
