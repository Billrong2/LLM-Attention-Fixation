function f(strand::String, zmnc::String)::Int64 
    poz = findfirst(zmnc, strand)
    while poz !== nothing
        strand = strand[poz.stop+1:end]
        poz = findfirst(zmnc, strand)
    end
    return something(findlast(zmnc, strand), -1)
end
using Test

@testset begin

candidate = f;
	@test(candidate("", "abc") == -1)
end
