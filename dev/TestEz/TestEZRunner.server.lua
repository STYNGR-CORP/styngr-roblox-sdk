local TestEZ = require(game.ReplicatedStorage.Styngr.DevPackages.testez)

-- add any other root directory folders here that might have tests 
local testLocations = {
	game.ServerStorage,
	game.ReplicatedStorage.Styngr.Utils,
}
local reporter = TestEZ.TextReporter
--local reporter = TestEZ.TextReporterQuiet -- use this one if you only want to see failing tests

TestEZ.TestBootstrap:run(testLocations, reporter)