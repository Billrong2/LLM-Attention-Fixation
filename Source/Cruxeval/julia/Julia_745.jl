function f(address::String)::String 
    suffix_start = findfirst(isequal('@'), address) + 1
    if count(c -> c == '.', address[suffix_start:end]) > 1
        address = replace(address, "." * join(split(address, '@')[2].split('.')[1:2], "."), "")
    end
    return address
end
using Test

@testset begin

candidate = f;
	@test(candidate("minimc@minimc.io") == "minimc@minimc.io")
end
