local Types = require(script.Types)
local ThrowTypeError = require(script.ThrowTypeError)

local Gizmo2D = {}
local DefaultColor = Color3.new(1, 1, 1)

local function ApplyStroke(Element, properties, contextual)
	if properties.Stroke then 
		local UIStroke = Instance.new("UIStroke")
		UIStroke.ApplyStrokeMode = contextual and Enum.ApplyStrokeMode.Contextual or Enum.ApplyStrokeMode.Border
		UIStroke.Color = properties.Stroke or DefaultColor
		UIStroke.Thickness = properties.StrokeWeight or 1
		UIStroke.Parent = Element
	end
end

function Gizmo2D.Circle(position: Vector2, parent, properties: Types.Circle) : Frame
	ThrowTypeError("position", position, 1, "Vector2")
	
	local Element = Instance.new("Frame")
	Element.Name = "Circle"
	Element.AnchorPoint = Vector2.new(.5, .5)
	Element.BackgroundColor3 = properties.Fill or DefaultColor
	Element.BackgroundTransparency = properties.Fill and 0 or 1
	Element.BorderSizePixel = 0
	Element.Size = properties.Radius and UDim2.fromOffset(properties.Radius * 2, properties.Radius * 2) or UDim2.fromOffset(5, 5)
	Element.Position = UDim2.fromOffset(position.X, position.Y)
	Element.Parent = parent
	
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Element

	ApplyStroke(Element, properties)

	return Element
end

function Gizmo2D.Point(position: Vector2, parent, properties: Types.Point) : Frame 
	ThrowTypeError("position", position, 1, "Vector2")

	return Gizmo2D.Circle(position, parent, {
		Radius = 2.5,
		Fill = properties.Fill
	})
end

function Gizmo2D.Line(point1: Vector2, point2: Vector2, parent, properties: Types.Line) : Frame
	ThrowTypeError("point1", point1, 1, "Vector2")
	ThrowTypeError("point2", point2, 2, "Vector2")

	local center = (point1 + point2)/2
	local dif = point2 - point1
	local length = dif.Magnitude
	local theta = math.atan2(dif.Y, dif.X)
	
	local Element = Instance.new("Frame")
	Element.Name = "Line"
	Element.AnchorPoint = Vector2.new(.5, .5)
	Element.BackgroundColor3 = properties.Fill or DefaultColor
	Element.BackgroundTransparency = properties.Fill and 0 or 1
	Element.BorderSizePixel = 0
	Element.Position = UDim2.fromOffset(center.X, center.Y)
	Element.Size = UDim2.fromOffset(length, properties.Thickness or 1)
	Element.Rotation = math.deg(theta)
	Element.Parent = parent
	
	ApplyStroke(Element, properties)

	return Element	
end


function Gizmo2D.Rectangle(position: Vector2, parent, properties: Types.Rectangle) : Frame
	ThrowTypeError("position", position, 1, "Vector2")

	local Element = Instance.new("Frame")
	Element.Name = "Rectangle"
	Element.AnchorPoint = properties.Mode == "CENTER" and Vector2.new(.5, .5) or Vector2.new()
	Element.BackgroundColor3 = properties.Fill or DefaultColor
	Element.BackgroundTransparency = properties.Fill and 0 or 1
	Element.BorderSizePixel = 0
	Element.Position = UDim2.fromOffset(position.X, position.Y)
	Element.Size = UDim2.fromOffset(properties.Width, properties.Height)
	Element.Parent = parent
	
	ApplyStroke(Element, properties)
	
	return Element
end

function Gizmo2D.Square(position: Vector2, parent, properties: Types.Square) : Frame
	ThrowTypeError("position", position, 1, "Vector2")
	
	return Gizmo2D.Rectangle(position, parent, {
		Width = properties.Side,
		Height = properties.Side,
		Mode = properties.Mode,
		Fill = properties.Fill,
		Stroke = properties.Stroke,
		StrokeWeight = properties.StrokeWeight
	})
end


function Gizmo2D.Triangle(point1: Vector2, point2: Vector2, point3: Vector2, parent, properties: Types.Triangle) : (ImageLabel, ImageLabel)
	ThrowTypeError("point1", point1, 1, "Vector2")
	ThrowTypeError("point2", point2, 2, "Vector2")
	ThrowTypeError("point3", point3, 3, "Vector2")

	-- Thanks to EgoMoose for the images.
	local TriangleImage1 = "rbxassetid://319692151"
	local TriangleImage2 = "rbxassetid://319692171"

	local s1 = point2 - point1
	local s2 = point3 - point2
	local s3 = point3 - point1
	
	local s1Dot, s2Dot, s3Dot = s1:Dot(s1), s2:Dot(s2), s3:Dot(s3)
	
	if (s1Dot > s3Dot and s1Dot > s2Dot) then
		point3, point1 = point1, point3
	elseif (s3Dot > s2Dot and s3Dot > s1Dot) then
		point1, point2 = point2, point1
	end
	
	s1 = point2 - point1
	s2 = point3 - point2
	s3 = point3 - point1

	local c1 = (point1 + point2)/2
	local c2 = (point1 + point3)/2
	
	local h = s2.Unit:Cross(s1)
	local right = h >= 0
	local theta = math.atan2(s2.Unit.Y, s2.Unit.X) + (right and 0 or math.pi)
	
	local TriangleA = Instance.new("ImageLabel")
	TriangleA.Name = "TriangleA"
	TriangleA.AnchorPoint = Vector2.new(.5, .5)
	TriangleA.BackgroundTransparency = 1
	TriangleA.ImageColor3 = properties.Fill or DefaultColor
	TriangleA.Size = UDim2.fromOffset(math.abs(s2.Unit:Dot(s1)), h)
	TriangleA.Position = UDim2.fromOffset(c1.X, c1.Y)
	TriangleA.Rotation = math.deg(theta)
	TriangleA.Image = right and TriangleImage1 or TriangleImage2

	local TriangleB = TriangleA:Clone()
	TriangleB.Name = "TriangleB"
	TriangleB.Size = UDim2.fromOffset(math.abs(s2.Unit:Dot(s3)), h)
	TriangleB.Position = UDim2.fromOffset(c2.X, c2.Y)
	TriangleB.Image = right and TriangleImage2 or TriangleImage1
	
	TriangleA.Parent = parent
	TriangleB.Parent = parent
	
	return TriangleA, TriangleB
end

function Gizmo2D.Arrow(point1: Vector2, point2: Vector2, parent, properties: Types.Arrow) : Frame
	ThrowTypeError("point1", point1, 1, "Vector2")
	ThrowTypeError("point2", point2, 2, "Vector2")
	
	local Arm = Gizmo2D.Line(point1, point2, parent, {
		Fill = properties.Fill,
		Thickness = properties.Thickness
	})
	
	local dif = point2 - point1
	local r = (properties.Thickness or 1) + 10
	
	local t1 = math.atan2(dif.Y, dif.X) + math.rad(-90)
	local t2 = math.atan2(dif.Y, dif.X) + math.pi/2
	
	local p = point1 + (point2 - point1).Unit * ((point2 - point1).Magnitude - r)
	
	local b = p + Vector2.new(math.cos(t1) * r/1.5, math.sin(t1) * r/1.5)
	local c = p + Vector2.new(math.cos(t2) * r/1.5, math.sin(t2) * r/1.5)
	
	local HeadA, HeadB = Gizmo2D.Triangle(point2, b, c, parent, {
		Fill = properties.Fill
	})
	HeadA.ZIndex = Arm.ZIndex + 1
	HeadB.ZIndex = Arm.ZIndex + 1

	return Arm
end

function Gizmo2D.Label(position: Vector2, parent, properties: Types.Label)
	ThrowTypeError("position", position, 1, "Vector2")

	local Element = Instance.new("TextLabel")
	Element.Name = "Label"
	Element.BackgroundTransparency = 1
	Element.Size = UDim2.fromOffset(properties.Size.X, properties.Size.Y)
	Element.Position = UDim2.fromOffset(position.X, position.Y)
	Element.Text = properties.Text
	Element.TextColor3 = properties.TextFill or DefaultColor
	Element.TextSize = properties.TextSize or 14
	Element.TextScaled = properties.TextScaled or false
	Element.Font = properties.Font or Enum.Font.SourceSans
	Element.Parent = parent
	
	ApplyStroke(Element, properties, true)
	
	return Element
end

return Gizmo2D
