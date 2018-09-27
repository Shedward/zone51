
def sayGoodbuy(name)
	result = "Goodnight, #{name}"
	return result
end

puts sayGoodbuy("Karl")

words = %w[Hello my name is John]

dict = {
	'John' => 'Faggot',
	'Sam' => 'Op'
}

puts dict


histogram = Hash.new(0)


testString = "Hello this is a Ruby test."

if testString =~ /Ruby/
	puts "Have rubby in string"
end

puts testString.sub(/\bRu(.*?)\b/,"Naft")

words = %w[Hello this is a multyword test string]

words.each { |word|
	puts word
}

puts ARGF