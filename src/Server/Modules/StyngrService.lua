--[=[
	@class StyngrService

	Core service for all server side SDK methods
]=]

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Promise = require(ReplicatedStorage.Styngr.Packages.promise)
local CloudService = require(script.Parent.CloudService)

local StyngrService = {}

function StyngrService:SetConfiguration(inputConfiguration)
	assert(
		inputConfiguration
			and inputConfiguration.apiKey
			and typeof(inputConfiguration.apiKey) == "string"
			and inputConfiguration.appId
			and typeof(inputConfiguration.appId) == "string",
		"Please specify a configuration and ensure all values are correct!"
	)

	if inputConfiguration.apiServer then
		assert(
			typeof(inputConfiguration.apiServer) == "string",
			"Please specify a configuration and ensure all values are correct!"
		)
	else
		inputConfiguration.apiServer = "https://tst.api.styngr.com/api/sdk/"
	end

	self._cloudService = CloudService.new(inputConfiguration)
	self._configuration = inputConfiguration
end

function StyngrService:GetPlaylists(userId: number)
	assert(
		self._cloudService,
		"Please initialize StyngrService using StyngrService.SetConfiguration() before calling this method!"
	)

	return self._cloudService
		:GetToken(userId)
		:andThen(function(token)
			return self._cloudService:Call(token, "integration/playlists", "GET")
		end)
		:andThen(function(result)
			return Promise.new(function(resolve, reject)
				local body = HttpService:JSONDecode(result.Body)

				if body["playlists"] then
					resolve(body["playlists"])
				else
					reject()
				end
			end)
		end)
end

function StyngrService:StartPlaylistSession(userId: number, playlistId: string)
	assert(
		self._cloudService,
		"Please initialize StyngrService using StyngrService.SetConfiguration() before calling this method!"
	)

	--[[
		TODO: Determine logical flow here, along with how we want to handle state.
		-> some of the current endpoints indicate that the backend is tracking some leevel of state,
		-> wondering if we want to offload state entirely to them or if we should handle state on our end as well,
		-> the latter option seems higher complexity and could cause edge cases where state on our end doesn't align with the backend,
	]]
end

--[[
	Initialization method
]]
function StyngrService:Init()
	self._cloudService = {}
	self._configuration = {}
end

--[[
	Start method
]]
function StyngrService:Start() end

return StyngrService
