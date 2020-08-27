using CategoricalArrays
import Statistics

"""
    reorder!(fac::::CategoricalVector, v::Vector{<:Real}, f::Function=Statistics.mean)

Assign the levels of the ordered categorical vector `fac` in increasing order of `f(v)`
applied to what would be written in R as `split(v)`.
"""
function reorder!(fac::CategoricalVector, v::Vector{<:Real}, f::Function=Statistics.mean)
    if length(fac) ≠ length(v)
        throw(DimensionMismatch("lengths of fac and v must be equal"))
    end
    dict = Dict(l => eltype(v)[] for l in levels(fac))
    for (l, vv) in zip(fac, v)
        push!(dict[l], vv)
    end
    levels!(fac, collect(keys(sort(Dict(k => f(v) for (k,v) in dict), byvalue=true))))
end
