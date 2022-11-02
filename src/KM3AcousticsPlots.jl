module KM3AcousticsPlots

using KM3Acoustics
using GLMakie
using Statistics
using Dates
using Colors

export
    hist, meshscatter

include("2dplots.jl")
include("3dplots.jl")
end
