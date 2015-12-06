class Number < Struct.new(:value)
	def to_s
		value.to_s
	end

	def inspect
		"<#{self}>"
	end

	def reducible?
		false
	end
end

class Add < Struct.new(:left, :right)
	def to_s
		"(#{left} + #{right})"
	end

	def inspect
		"<#{self}>"
	end

	def reducible?
		true
	end

	def reduce(enviroment)
		if left.reducible?
			Add.new(left.reduce(enviroment), right)
		elsif right.reducible?
			Add.new(left, right.reduce(enviroment))
		else 
			Number.new(left.value + right.value)
		end
	end
end

class Multiply < Struct.new(:left, :right)
	def to_s
		"(#{left} * #{right})"
	end

	def inspect
		"<#{self}>"
	end

	def reducible?
		true
	end

	def reduce(enviroment)
		if left.reducible?
			Multiply.new(left.reduce(enviroment), right)
		elsif right.reducible?
			Multiply.new(left, right.reduce(enviroment))
		else 
			Number.new(left.value * right.value)
		end
	end
end

class Variable < Struct.new(:name)
	def to_s
		name.to_s
	end

	def inspect
		"<#{self}>"
	end

	def reducible?
		true
	end

	def reduce(enviroment)
		enviroment[name]
	end
end

class DoNothing
	def to_s
		"do-nothing"
	end

	def inspect
		"<#{self}>"
	end

	def ==(other_statement)
		other_statement.instance_of?(DoNothing)
	end

	def reducible?
		false
	end
end

class Assign < Struct.new(:name, :expression)
	def to_s
		"#{name} = #{expression}"
	end

	def inspect
		"<#{self}>"
	end

	def reducible? 
		true
	end

	def reduce(enviroment)
		if expression.reducible?
			[Assign.new(name, expression.reduce(enviroment)), enviroment]
		else
			[DoNothing.new, enviroment.merge({ name => expression})]
		end
	end
end

class Machine < Struct.new(:expression, :enviroment)
	def step
		self.expression, self.enviroment = expression.reduce(enviroment)
	end

	def run
		while expression.reducible?
			puts "#{expression}: #{expression}"
			step			
		end
		puts "#{expression}: #{expression}"
	end
end

expression = Add.new(
	Multiply.new(Number.new(1), Number.new(2)),
	Multiply.new(Number.new(3), Variable.new(:x))
	)

enviroment = {
	x: Number.new(3)
}

machine = Machine.new(expression, enviroment)
machine.run
