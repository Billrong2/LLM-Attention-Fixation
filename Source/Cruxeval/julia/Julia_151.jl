function f(text::String)::String 
    for c in text
        if isdigit(c)
            if c == '0'
                c = '.'
            else
                c = c == '1' ? '.' : '0'
            end
        end
    end
    return replace(join(collect(text), ""), '.' => '0')
end
using Test

@testset begin

candidate = f;
	@test(candidate("697 this is the ultimate 7 address to attack") == "697 this is the ultimate 7 address to attack")
end
