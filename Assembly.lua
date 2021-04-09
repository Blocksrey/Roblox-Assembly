local Assembly = {}
Assembly.__index = Assembly

function Assembly.new(model, cframe)
	local self = setmetatable({}, Assembly)
	
	self:ConstructFrom(model, cframe)
	
	return self
end

function Assembly:ConstructFrom(model, cframe)
	self._assembly = {}

	for _, object in next, model:GetDescendants() do
		if object:IsA("BasePart") then
			self._assembly[object] = cframe:Inverse()*object.CFrame
		end
	end
end

function Assembly:Transform(cframe)
	for part, offset in next, self._assembly do
		part.CFrame = cframe*offset
	end
end

function Assembly:Destroy()
	self._assembly = nil
	
	setmetatable(self, nil)
end

return Assembly