
import Pkg
using Combinatorics, DataFrames, LinearAlgebra, StatsBase, Base.Threads, Octavian

function DAG_space_gen(n)
    @assert n > 1 "Generates all possible DAGs for n > 1"

    nthreads = convert(Int, 2^(floor(log2(Threads.nthreads()))))

    m = binomial(n, 2)
    choices = repeat(collect.([0:1]), m)
    choices = Base.product(choices...) |> DataFrame
    nchoices = 2^m
    pvertex = permutations(1:n) |> collect
    npvertex = factorial(n)
    
    nthreads = nthreads >= nchoices ? nthreads = 1 : nthreads
    multiple = convert(Int, nchoices / nthreads)

    idmatrix = [[convert.(Int8, Matrix(1I, n, n))] for _ in 1:nthreads]
    adjc_matrix = [[convert.(Int8, Matrix(0I, n, n))] for _ in 1:nthreads]

    chunks = Matrix[[1 multiple]]
    for q in 2:nthreads
        push!(chunks, [(chunks[q-1][2]+1) (multiple * (q))])
    end

    @threads for t in 1:nthreads
        threadID = nthreads > 1 ? Threads.threadid() : 1

        for i in chunks[threadID][1]:chunks[threadID][2]
            base_matrix = convert.(Int8, fill(0, (n, n)))
            z = reshape(repeat(1:n, n), (n, n,))
            upper_triangle = z .< z'
            base_matrix[upper_triangle] = collect(choices[i, :])

            for j in 1:npvertex
                candidate = matmul!(idmatrix[threadID][][:, pvertex[j]], base_matrix, idmatrix[threadID][][pvertex[j], :])
                push!(adjc_matrix[threadID], candidate)
            end
        end
    end

    return unique(reduce(vcat, adjc_matrix))
end

@time x = DAG_space_gen(5)