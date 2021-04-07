-- @AlexOp_ was here

local tree
local max_dist = 500
local min_dist = 10
local width, height = 400, 400

local Branch = require(script.Branch)
local Leaf = require(script.Leaf)

local Tree = {}
Tree.__index = Tree

function Tree.new()
	local self = setmetatable({
		leaves = {},
		branches = {}
	},Tree)
	for i = 1, 500 do
		table.insert(self.leaves, Leaf.new(width, height))
	end
	local pos = Vector3.new(width / 2, 0, 0)
	local dir = Vector3.new(0, -1, 0)
	local root = Branch.new(nil, pos, dir)
	table.insert(self.branches, root)
	local current = root
	local found = false
	while not found do
		for i = 1, #self.leaves do
			local d = (current.pos - self.leaves[i].pos).Magnitude
			if d < max_dist then
				found = true
			end
		end
		if not found then
			local branch = current:next()
			current = branch
			table.insert(self.branches, current)
		end
	end
	return self
end

function Tree:grow()
	for i = 1, #self.leaves do
		local leaf = self.leaves[i]
		local closestBranch = nil
		local record = max_dist
		for j = 1, #self.branches do
			local branch = self.branches[j]
			local d = (leaf.pos - branch.pos).Magnitude
			if d < min_dist then
				leaf.reached = true
				closestBranch = nil
				break
			elseif d < record then
				closestBranch = branch
				record = d
			end
		end
		if closestBranch ~= nil then
			local newDir = (leaf.pos - closestBranch.pos).Unit
			closestBranch.dir += newDir
			closestBranch.count += 1
		end
	end

	for i = #self.leaves-1, 1, -1 do
		if self.leaves[i].reached then
			table.remove(self.leaves, i)
		end
	end
	
	for i = 1, #self.branches do
		local branch = self.branches[i]
		if branch.count > 0 then
			branch.dir /= branch.count + 1
			table.insert(self.branches, branch:next())
			branch:reset()
		end
	end
end

function Tree:show()
	for i = 1, #self.leaves do
		self.leaves[i]:show()
	end
	for i = 1, #self.branches do
		self.branches[i]:show()
	end
end

tree = Tree.new()
while wait(0.05) do
	tree:show()
	tree:grow()
end
