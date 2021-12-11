export type Circle = {
	Radius: number,
	Fill: Color3?,
	Stroke: Color3?,
	StrokeWeight: number?
}

export type Point = {
	Fill: Color3?
}

export type Line = {
	Thickness: number?,
	Fill: Color3?,
	Stroke: Color3?,
	StrokeWeight: number?
}

export type Arrow = {
	Thickness: number?,
	Fill: Color3?,
}

export type Triangle = {
	Fill: Color3?,
}

export type Rectangle = {
	Width: number,
	Height: number,
	Fill: Color3?,
	Stroke: Color3?,
	Mode: string?,
	StrokeWeight: number?,
}

export type Square = {
	Side: number,
	Fill: Color3?,
	Stroke: Color3?,
	Mode: string?,
	StrokeWeight: number?,
}

export type Label = {
	Text: string,
	Size: Vector2,
	TextSize: number?,
	TextFill: Color3?,
	TextStroke: Color3?,
	TextStrokeWeight: number?,
	TextScaled: boolean?,
	Font: EnumItem | string,
}

return nil
