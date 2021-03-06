
import Pkg
using Combinatorics, LinearAlgebra, Base.Threads, Octavian, Chain

function DAG_space_gen(n)
    @assert n > 1 "Generates all possible DAGs for n > 1"

    threads = Threads.nthreads()

    m = binomial(n, 2)
    choices = repeat(collect.([Int8(0):Int8(1)]), m)
    choices = Base.product(choices...) |> collect;
    nchoices = 2^m
    pvertex = permutations(Int8(1):Int8(n)) |> collect
    npvertex = factorial(n)
    
    threads = threads >= nchoices ? 1 : threads

    adjc_matrix = [[convert.(Int8, Matrix(0I, n, n))] for _ in 1:threads]

    multiple = div(nchoices, threads)
    chunks = Matrix[[1 multiple]]
    for q in 2:threads
        if size(chunks, 1) < threads - 1
            push!(chunks, [(chunks[q-1][2]+1) (multiple * q)])
        else
            if  (multiple * threads) == nchoices
                push!(chunks, [(chunks[q-1][2]+1) (multiple * q)])
            else
                push!(chunks, [(chunks[q-1][2]+1) ((multiple * q) + (nchoices - (multiple * q)))])
            end
        end
    end

    @threads for t in 1:threads
        threadID = threads > 1 ? Threads.threadid() : 1
        
        idmatrix = [convert.(Int8, Matrix(1I, n, n))][]
        base_matrix = fill(Int8(0), (n, n))
        upper_triangle = @chain reshape(repeat(Int8(1):Int8(n), n), (n, n)) _ .< _'

        for i in chunks[threadID][1]:chunks[threadID][2]
            base_matrix[upper_triangle] = collect(choices[i])

            for j in 1:npvertex
                candidate = matmul(idmatrix[pvertex[j], :], base_matrix)
                push!(adjc_matrix[threadID], candidate)
            end
        end
    end

    return unique(reduce(vcat, adjc_matrix))
end

@time x = DAG_space_gen(5)
