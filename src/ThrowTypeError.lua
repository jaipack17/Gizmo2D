return function (argName: string, received: any, at: number, expected: string)
	if typeof(received) ~= expected then 
		string.format(
			"Invalid Argument #%d. Expect type %s for %q, got %s.",
			at,
			expected,
			argName,
			typeof(received)
		)
	end
end

