-- @AlexOp_ was here
-- Place as a module in Tree script

local Branch = {}
Branch.__index = Branch

function Branch.new(parent, pos, dir)
	local ndir = dir
	return setmetatable({
		pos = pos,
		parent = parent,
		dir = dir,
		origDir = ndir,
		count = 0,
		len = 5
	},Branch)
end

function Branch:reset()
	self.dir = self.origDir
	self.count = 0
end

function Branch:next()
	local nextDir = self.dir * self.len
	local nextPos = self.pos + nextDir
	local nextBranch = Branch.new(self, nextPos, self.dir)
	return nextBranch
end

function Branch:show()
	if self.parent ~= nil then
		local line = Instance.new("Part")
		local pos1, pos2 = Vector3.new(self.parent.pos.x,self.parent.pos.y,0), Vector3.new(self.pos.x, self.pos.y, 0)
		local Center = (pos1 + pos2) / 2
		line.CFrame = CFrame.lookAt(Center, pos1)
		line.Size = Vector3.new(1, 1, (pos1 - pos2).Magnitude)
		line.Anchored = true
		line.Color = BrickColor.Black().Color
		line.Parent = workspace
	end
end

return Branch
