function f(simpons::Vector{String})::String
    while !isempty(simpons)
        pop = pop!(simpons)
        if pop == titlecase(pop)
            return pop
        end
    end
    return pop
end

using Test

@testset begin

candidate = f;
	@test(candidate(["George", "Michael", "George", "Costanza"]) == "Costanza")
end
