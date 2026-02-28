function f(text::String)::String 
    global g, field
    field = replace(text, ' ' => "")
    global g = replace(text, '0' => ' ')
    text = replace(text, '1' => 'i')

    return text
end
using Test

@testset begin

candidate = f;
	@test(candidate("00000000 00000000 01101100 01100101 01101110") == "00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0")
end
