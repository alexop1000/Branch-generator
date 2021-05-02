-- @AlexOp_ was here
-- Place as a module in Tree script

local Leaf = {}
Leaf.__index = Leaf

function Leaf.new(width, height)
	return setmetatable({
		pos = Vector3.new(math.random(width), math.random(height-100)+100, 0),
		reached = false,
		part = nil
	},Leaf)
end

function Leaf:show()
	local ellipse = self.part
	if self.part == nil then
		ellipse = Instance.new("Part")
	end
	self.part = ellipse
	ellipse.Shape = Enum.PartType.Cylinder
	ellipse.Size = Vector3.new(4,4,4)
	ellipse.Position = Vector3.new(self.pos.x,self.pos.y, 0)
	ellipse.Anchored = true
	ellipse.Parent = workspace
	ellipse.Transparency = 1
end

return Leaf
