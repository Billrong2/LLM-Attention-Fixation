function f(lines::Vector{String})::Vector{String} 
    for i in 1:length(lines)
        lines[i] = lpad(lines[i], length(lines[end]), ' ')
    end
    return lines
end
using Test

@testset begin

candidate = f;
	@test(candidate(["dZwbSR", "wijHeq", "qluVok", "dxjxbF"]) == ["dZwbSR", "wijHeq", "qluVok", "dxjxbF"])
end
