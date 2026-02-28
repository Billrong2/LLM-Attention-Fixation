function f(text::String, char::String)::String 
    if !isempty(text)
        text = replace(text, "^$char" => "")
        text = replace(text, "^$(text[end])" => "")
        text = text[1:end-1] * uppercase(text[end])
    end
    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("querist", "u") == "querisT")
end
