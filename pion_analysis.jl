using Plots
using Statistics

function read_last_line(filename::String)
    lines = readlines(filename)

    last_run = last(lines)

    vals_str = split(strip(split(last_run, "#")[1]), " ")[2:end]
    vals = parse.(Float64, vals_str)

    return vals
end

function read_first_line(filename::String)
    lines = readlines(filename)

    first_run = lines[1]

    vals_str = split(strip(split(first_run, "#")[1]), " ")[2:end]
    vals = parse.(Float64, vals_str)

    return vals
end

function effective_mass(c_vals::Vector)
    n = length(c_vals) - 1
    m_eff = Array{Float64}(undef, n)
    for i in 1:n
        m_eff[i] = abs(log(c_vals[i] / c_vals[i+1]))
    end

    return m_eff
end

function mass_plateau(c_vals::Vector)
    m_eff = effective_mass(c_vals)

    nt_half = 0.5:1:(length(c_vals)-1)

    p1_start = 7
    p1_end = 15

    plateau_idx = p1_start .< nt_half .< p1_end

    plateau = m_eff[plateau_idx]

    return plateau
end

vals_2 = read_last_line("measurements/wilson/m_0.2_long/Pion_correlator.txt")
vals_1 = read_last_line("measurements/wilson/m_0.1_long/Pion_correlator.txt")
vals_05 = read_last_line("measurements/wilson/m_0.05_long/Pion_correlator.txt")
vals_025 = read_last_line("measurements/wilson/m_0.025_long/Pion_correlator.txt")

nt = 1:length(vals_2)

p = plot(nt, vals_2, yaxis=:log, label="m = 0.2", seriestype=:scatter, shape=:circle)
plot!(nt, vals_1, label="m = 0.1", seriestype=:scatter, shape=:utriangle)
plot!(nt, vals_05, label="m = 0.05", seriestype=:scatter, shape=:square)
plot!(nt, vals_025, label="m = 0.025", seriestype=:scatter, shape=:star6)
xlabel!("nt")
ylabel!("C(nt)")

println("Saving correlator plot...")

savefig(p, "plots/mass_scan.png")
savefig(p, "plots/mass_scan.pdf")

#####
# Compute effective mass
#####

nt_half = 0.5:1:(length(vals_2)-1)
# nt_half, mass_2 = mass_plateau(vals_2)

p = plot(nt_half, effective_mass(vals_2), label="m = 0.2", seriestype=:scatter, shape=:circle)

plot!(nt_half, effective_mass(vals_1), label="m = 0.1", seriestype=:scatter, shape=:utriangle)
plot!(nt_half, effective_mass(vals_05), label="m = 0.05", seriestype=:scatter, shape=:square)
plot!(nt_half, effective_mass(vals_025), label="m = 0.05", seriestype=:scatter, shape=:star6)
xlabel!("nt")
ylabel!("m_eff")

vline!([7, 15], label="Plateau region", color="black")

println("Saving mass plot...")

savefig(p, "plots/mass_scan_meff.png")
savefig(p, "plots/mass_scan_meff.pdf")


#####
# Compute pion mass scaling
#####

m_q_vals = [0.2, 0.1, 0.05, 0.025]
m_eff_vals = broadcast(mean, broadcast(mass_plateau, [vals_2, vals_1, vals_05, vals_025]))
m_eff_std = broadcast(std, broadcast(mass_plateau, [vals_2, vals_1, vals_05, vals_025]))

println(m_q_vals)
println(m_eff_vals)
println(m_eff_std)

p = plot(m_q_vals, m_eff_vals, seriestype=:scatter)
xlabel!("m_q")
ylabel!("m_eff")

println("Saving pion vs quark mass plot...")

savefig(p, "plots/mass_scan_pion_vs_quark.png")
savefig(p, "plots/mass_scan_pion_vs_quark.pdf")
