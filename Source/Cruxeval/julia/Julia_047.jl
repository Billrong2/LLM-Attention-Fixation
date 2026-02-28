function f(text::String)::Bool 
    length_text = length(text)
    half = div(length_text, 2)
    encode = codeunits(text[1:half])
    return text[half+1:end] == String(encode)
end
using Test

@testset begin

candidate = f;
	@test(candidate("bbbbr") == false)
end
