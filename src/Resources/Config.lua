local Environment = {}

--// Configuration

-- LogProcess
Environment[1] = true -- If set to true, logs the sandbox's process

-- AutoSubstituteSuspiciousLoops
Environment[2] = false -- If set to true, the sandbox will substitute suspicious loops automatically without asking you

-- WaitDurationMax
Environment[3] = 0 -- Duration cap, if the passed <uint> Duration parameter is bigger then this number, it will be rounded to this number

--\\

return Environment