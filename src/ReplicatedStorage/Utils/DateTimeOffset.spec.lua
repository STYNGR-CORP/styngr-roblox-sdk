local SECONDS_IN_MINUTE = 60
local SECONDS_IN_HOUR = 60 * SECONDS_IN_MINUTE

return function()
    local DateTimeOffset = require(script.parent.DateTimeOffset)
    
    describe("GetOffset", function()
        it("should properly return positive full hour", function()
            local result = DateTimeOffset.GetOffset(SECONDS_IN_HOUR)
            expect(result).to.equal("UTC+01:00")
        end)

        it("should properly return negative full hour", function()
            local result = DateTimeOffset.GetOffset(-SECONDS_IN_HOUR)
            expect(result).to.equal("UTC-01:00")
        end)

        it("should properly return positive partial hour", function()
            local result = DateTimeOffset.GetOffset(SECONDS_IN_HOUR + SECONDS_IN_MINUTE)
            expect(result).to.equal("UTC+01:01")
        end)

	    it("should properly return negative partial hour", function()
            local result = DateTimeOffset.GetOffset(-(SECONDS_IN_HOUR + SECONDS_IN_MINUTE))
            expect(result).to.equal("UTC-01:01")
        end)

        it("should properly return zero offset", function()
            local result = DateTimeOffset.GetOffset(0)
            expect(result).to.equal("UTC+00:00")
        end)
    end)
end
