using Plots

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

vals_2 = read_last_line("measurements/wilson/m_0.2/Pion_correlator.txt")
vals_1 = read_last_line("measurements/wilson/m_0.1/Pion_correlator.txt")
vals_05 = read_last_line("measurements/wilson/m_0.05/Pion_correlator.txt")
# vals_025 = read_last_line("measurements/wilson/m_0.025/Pion_correlator.txt")

nt = 1:length(vals_2)

p = plot(nt, vals_2, yaxis=:log, label="m = 0.2")
plot!(nt, vals_1, label="m = 0.1")
plot!(nt, vals_05, label="m = 0.05")
# plot!(nt, vals_025, label="m = 0.025")
xlabel!("nt")
ylabel!("C(nt)")

print("Saving plot...")

savefig(p, "plots/mass_scan.png")
savefig(p, "plots/mass_scan.pdf")