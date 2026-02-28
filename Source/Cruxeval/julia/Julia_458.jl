function f(text::String, search_chars::String, replace_chars::String)::String 
    trans_table = Dict{Char, Char}()
    for (i, search_char) in enumerate(search_chars)
        trans_table[search_char] = replace_chars[i]
    end
    return join([get(trans_table, c, c) for c in text])
end
using Test

@testset begin

candidate = f;
	@test(candidate("mmm34mIm", "mm3", ",po") == "pppo4pIp")
end
