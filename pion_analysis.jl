using Plots

lines = readlines("measurements/HMC_L04040404_beta5.7_Staggered_mass0.5_Nf2/Pion_correlator_small.txt")

last_run = last(lines)

vals_str = split(strip(split(last_run, "#")[1]), " ")[2:end]
vals = parse.(Float64, vals_str)

nt = 1:length(vals)

p = plot(nt, vals, yaxis=:log, labels=["m = 0.2"])
xlabel!("nt")
ylabel!("C(nt)")

savefig(p, "plots/first_run.png")
savefig(p, "plots/first_run.pdf")