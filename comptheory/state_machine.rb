require 'set'

class FARule < Struct.new(:state, :key, :next_state)
	def applies_to?(state, key)
		self.state == state && self.key == key		
	end

	def follow 
		next_state
	end

	def inspect
		"#<FARule #{state.inspect} --#{key}--> #{next_state.inspect}>"
	end
end

class DFARulebook < Struct.new(:rules)
	def next_state(state, key)
		rule_for(state, key).follow
	end

	def rule_for(state, key)
		rules.detect { |rule| rule.applies_to?(state, key) }
	end
end

class NFA < Struct.new(:current_states, :accept_states, :rulebook)
	def accepting?
		(current_states & accept_states).any?
	end

	def read_character(character)
		self.current_states = rulebook.next_state(current_states, character)
	end

	def read_string(string)
		string.chars.each do |character|
			read_character(character)
		end
	end
end

rulebook = DFARulebook.new([
	FARule.new(1, 'a', 2),
	FARule.new(1, 'b', 1),
	FARule.new(2, 'a', 2),
	FARule.new(2, 'b', 3),
	FARule.new(3, 'a', 3),
	FARule.new(3, 'b', 3)
	])

nfa = NFA.new(Set[1], [4], rulebook); nfa.accepting?

nfa.read_string('bbbbb'); nfa.accepting?