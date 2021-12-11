<div align="center">
    <h1>Gizmo2D</h1>
    <p>A two-dimensional Roblox Visual Debugging Library</p>
</div>
<hr/>

Gizmo2D is inspired by Unity's Gizmo library. This library allows you to easily and quickly create visuals for debugging 2D information like lines, shapes, arrows and more. The library utilizes GuiObjects to render visual information. 

https://user-images.githubusercontent.com/74130881/145675560-f0537293-f495-4b63-806f-3df92df1578f.mp4

## Features

The library consists of the following visual debugging features.

* Circles
* Squares
* Rectangles
* Lines
* Arrows
* Triangles
* Points
* TextLabels

## Installation

To get your hands on the latest version of the library, go to the Releases page in the repository, select the latest release, download the Gizmo2D.rbxm binary. For a Rojo workflow, it is recommended to use [wally](), a package manager for roblox. If you have setup wally on your computer, put the following in your `wally.toml` file and install the dependencies.

```toml
[dependencies]
Gizmo2D = "jaipack17/gizmo2d@0.0.1"
```

After installing the dependencies, the library should be added to the Index of your Packages folder. You can then require the library and start using it.

## Usage

Require the library by simply typing in the following and replacing `path.to.gizmo2d` with the actual path in-game.

```lua
local Gizmo2D = require(path.to.gizmo2d)
```

Almost all tools for debugging have `Fill`, `Stroke` and `StrokeWeight` properties. These properties refer to the BackgroundColor and BorderColor for the object. If you wish to create transparent objects, pass in `Fill` as nil.

### `Gizmo2D.Circle()`

This method is used to draw circles with arbitrary radii on the screen. 

```lua
-- Parameters - Position: Vector2, Parent: Instance, Properties: table
Gizmo2D.Circle(Vector2.new(50, 50), SomeParent, {
    Radius = 25, -- number
    Fill = Color3.new(1, 1, 1), -- Color3|nil
    Stroke = Color3.new(1, 0, 0), -- Color3|nil
    StrokeWeight = 2 -- number|nil
})
```

### `Gizmo2D.Square()`

This method is used to draw squares with arbitrary side measurments on the screen. 

```lua
-- Parameters - Position: Vector2, Parent: Instance, Properties: table
Gizmo2D.Square(Vector2.new(50, 50), SomeParent, {
    Side = 50, -- number
    Mode = "CENTER", -- string|nil. Refers to the anchor point of the square. Must be either CENTER or nil
    Fill = Color3.new(1, 1, 1), -- Color3|nil
    Stroke = Color3.new(1, 0, 0), -- Color3|nil
    StrokeWeight = 2 -- number|nil
})
```

### `Gizmo2D.Rectangle()`

This method is used to draw rectangles with arbitrary width and height measurments on the screen. 

```lua
-- Parameters - Position: Vector2, Parent: Instance, Properties: table
Gizmo2D.Rectangle(Vector2.new(50, 50), SomeParent, {
    Width = 100, -- number
    Height = 50, -- number
    Mode = "CENTER", -- string|nil
    Fill = Color3.new(1, 1, 1), -- Color3|nil
    Stroke = Color3.new(1, 0, 0), -- Color3|nil
    StrokeWeight = 2 -- number|nil
})
```

### `Gizmo2D.Line()`

This method is used to draw a line segment given to points on the screen. 

```lua
-- Parameters - Point1: Vector2, Point2: Vector2, Parent: Instance, Properties: table
Gizmo2D.Line(Vector2.new(50, 50), Vector2.new(100, 100), SomeParent, {
    Thickness = 2, number|nil
    Fill = Color3.new(1, 1, 1), -- Color3|nil
    Stroke = Color3.new(1, 0, 0), -- Color3|nil
    StrokeWeight = 2 -- number|nil
})
```

### `Gizmo2D.Arrow()`

This method is used to draw an arrow/vector given to points on the screen. 

```lua
-- Parameters - Point1: Vector2, Point2: Vector2, Parent: Instance, Properties: table
Gizmo2D.Arrow(Vector2.new(50, 50), Vector2.new(100, 100), SomeParent, {
    Thickness = 2, number|nil
    Fill = Color3.new(1, 1, 1), -- Color3
})
```

### `Gizmo2D.Triangle()`


This method is used to draw triangles given 3 points on the screen. 

```lua
-- Parameters - Point1: Vector2, Point2: Vector2, Point3: Vector2, Parent: Instance, Properties: table
Gizmo2D.Triangle(Vector2.new(50, 50), Vector2.new(100, 100), Vector2.new(50, 100), SomeParent, {
    Fill = Color3.new(1, 1, 1), -- Color3
})
```

### `Gizmo2D.Point()`

This method is used to draw points on the screen, with a default radius of 2.5.

```lua
-- Parameters - Position: Vector2, Parent: Instance, Properties: table
Gizmo2D.Point(Vector2.new(50, 50), SomeParent, {
    Fill = Color3.new(1, 1, 1), -- Color3
})
```

### `Gizmo2D.Label()`

This method is used to draw text on screen by utilizing TextLabels. 

```lua
-- Parameters - Position: Vector2, Parent: Instance, Properties: table
Gizmo2D.Label(Vector2.new(50, 50), Vector2.new(100, 100), Vector2.new(50, 100), SomeParent, {
    Text = "Some Text", -- string
    Size = Vector2.new(30, 30), -- Vector2
    TextSize = 15, -- number|nil
    TextFill = Color3.new(1, 1, 1), -- Color3|nil
    TextStroke = Color3.new(1, 0, 1), -- Color3|nil
    TextStrokeWeight = 2, -- number|nil
    TextScaled = false, -- boolean|nil
    Font = Enum.Font.Gotham -- EnumItem|string|nil
})
```

<hr/>
