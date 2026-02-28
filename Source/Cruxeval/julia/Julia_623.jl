function f(text::String, rules::Vector{String})::String 
    for rule in rules
        if rule == "@"
            text = reverse(text)
        elseif rule == "~"
            text = uppercase(text)
        elseif !isempty(text) && text[end] == first(rule)
            text = text[1:end-1]
        end
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("hi~!", ["~", "`", "!", "&"]) == "HI~")
end
