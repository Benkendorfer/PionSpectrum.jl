# - - parameters - - - - - - - - - - - 
# Physical setting 
system["L"] = (16, 16, 16, 32)
system["β"] = 5.7
system["NC"] = 3
system["Nthermalization"] = 0
system["Nsteps"] = 100
system["initial"] = "cold"
system["initialtrj"] = 1
system["update_method"] = "HMC"
system["Nwing"] = 1
	
# Physical setting(fermions)
system["quench"] = true
system["Dirac_operator"] = "Wilson"
wilson["Clover_coefficient"] = 0
wilson["r"] = 1
wilson["hop"] = 0.1234567901234568
staggered["Nf"] = 0
staggered["mass"] = 0
system["BoundaryCondition"] = [1, 1, 1, -1]
	
# System Control
system["log_dir"] = "./logs"
system["logfile"] = "wilson_m_0.05.txt"
system["saveU_dir"] = ""
system["saveU_format"] = nothing
system["saveU_every"] = 10000
system["verboselevel"] = 2
system["randomseed"] = 111
measurement["measurement_basedir"] = "./measurements"
measurement["measurement_dir"] = "wilson/m_0.05_long"
	
# HMC related
md["Δτ"] = 0.14285714285714285
md["SextonWeingargten"] = false
md["N_SextonWeingargten"] = 2
md["MDsteps"] = 7
cg["eps"] = 1.0e-19
cg["MaxCGstep"] = 3000
	
# Action parameter for SLMC
actions["use_autogeneratedstaples"] = false
actions["couplingcoeff"] = Any[]
actions["couplinglist"] = Any[]
	
# Measurement set
measurement["measurement_methods"] = Dict[ 
  Dict{Any,Any}("methodname" => "Pion_correlator",
    "fermiontype" => "Wilson",
    "measure_every" => 1,
    "hop" => 0.1234567901234568
  )
]
	
# - - - - - - - - - - - - - - - - - - -
