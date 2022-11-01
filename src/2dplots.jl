function GLMakie.hist(event::Event; resolution=(500,500))
    toes = Float64[]
    sizehint!(toes, length(event.data))
    for transmission in event.data
        push!(toes, transmission.TOE)
    end
    date, time = split(string(unix2datetime(mean(toes))), "T")
    time = split(time, ".")[1]
    toes = toes .- mean(toes)
    f = Figure(resolution=resolution)
    ax = Axis(f[1, 1])
    ax.xlabel = "time of emission [s]"
    ax.xlabelsize = 15
    ax.title = "Event from emitter $(event.id) on $(date) at $(time)"
    b = 50
    hist!(toes, color = :red, bins=b, strokewidth=1, strokecolor = :black)
    diff = maximum(toes) - minimum(toes)
    st_diff = std(toes)
    # xlims!(ax, [minimum(toes), maximum(toes)])
    xlims!(ax, -st_diff, st_diff)
    f
end
