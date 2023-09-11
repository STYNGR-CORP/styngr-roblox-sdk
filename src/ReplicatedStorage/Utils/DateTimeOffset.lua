local DateTimeOffset = {}
local SECONDS_IN_MINUTE = 60
local SECONDS_IN_HOUR = 60 * SECONDS_IN_MINUTE

function DateTimeOffset.GetOffset(seconds)
	if seconds == 0 then
		return "UTC+00:00"
	end

	local offsetString = "UTC"

	local absoluteValue = math.abs(seconds)
	local sign = absoluteValue / seconds
	local hours = math.floor(absoluteValue / SECONDS_IN_HOUR)
	local minutes = math.floor(((absoluteValue - (hours * SECONDS_IN_HOUR)) / SECONDS_IN_MINUTE))
	hours = hours * sign

	if hours > 0 then
		offsetString = offsetString .. "+"
	end

	return offsetString .. string.format("%0.2i:%0.2i", hours, minutes)
end

function DateTimeOffset.GetCurrentUtcOffset()
	-- Get the current UTC time
	local utcTime = os.time(os.date("!*t"))

	-- Get the local time
	local localTime = os.time(os.date("*t"))

    -- Calculate the timezone offset in seconds
	local timezoneOffset = os.difftime(localTime, utcTime)

	return DateTimeOffset.GetOffset(timezoneOffset) 
end

return DateTimeOffset
