function f(text::String)::String
    uppercase_index = findfirst(isequal('A'), text)
    if uppercase_index !== nothing
        return text[1:uppercase_index-1] * text[findnext(isequal('a'), text, uppercase_index):end]
    else
        return join(sort([collect(text)...]))
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("E jIkx HtDpV G") == "   DEGHIVjkptx")
end
