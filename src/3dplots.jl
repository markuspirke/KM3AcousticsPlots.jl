function GLMakie.meshscatter(detector::Detector; resolution=(1000, 1000))
    ps = Position[]
    sizehint!(ps, length(detector))
    for mod in detector
        push!(ps, mod.pos)
    end
    @show "WOOF"
    f = Figure(resolution=resolution, aspect=(1.0, 1.0, 10.0))
    ax = Axis3(f[1, 1])
    ax.xlabel = "x"
    ax.ylabel = "y"
    ax.zlabel = "z"

    meshscatter!(Vec3f.(ps), markersize=5)

    f, ax
end

function GLMakie.meshscatter(detector::Detector, emitters::Dict{Int8, Emitter}; resolution=(1000, 1000))
    ps = Position[]
    sizehint!(ps, length(detector))
    for mod in detector
        push!(ps, mod.pos)
    end

    ps_emitter = Position[]
    for emitter in values(emitters)
        push!(ps_emitter, emitter.pos)
    end

    f = Figure(backgroundcolor = :grey91, resolution=resolution)
    ax = Axis3(f[1, 1])
    ax.xlabel = "x"
    ax.ylabel = "y"
    ax.zlabel = "z"

    meshscatter!(Vec3f.(ps), markersize=5)
    meshscatter!(Vec3f.(ps_emitter), markersize=5, color=:red)
    # text!("WOOOOOF", [500.0, 500.0, 100.0])

    f, ax
end

function event_visual(detector::Detector, emitters::Dict{Int8, Emitter}, event::Event)
    f, ax = meshscatter(detector, emitters)
    meshscatter!(ax, Vec3f(emitters[event.id].pos), markersize=5, color=:magenta1)
    ps = Position[]
    for transmission in event.data
        for mod in detector
            if mod.location == Location(transmission.string, transmission.floor)
                push!(ps, mod.pos)
            end
        end
    end
    meshscatter!(ax, Vec3f.(ps), markersize=5, color=:magenta1)

    toes = Float64[]
    sizehint!(toes, length(event.data))
    for transmission in event.data
        push!(toes, transmission.TOE)
    end
    date, time = split(string(unix2datetime(mean(toes))), "T")
    time = split(time, ".")[1]

    ax.title = "Detector: $(detector.id), Run: $(event.run) \n Event from emitter $(event.id) on $(date) at $(time)"
    ax.titlesize = 20
    f, ax
end
