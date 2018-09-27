require "forwardable"

class Song 
	def initialize(name, artist, duration)
		@name = name 
		@artist = artist
		@duration = parse_duration(duration)
	end

	attr_reader :name, :artist, :duration
	attr_writer :name, :artist

	def durationInMinutes
		@duration / 60.0
	end

	def durationInMinutes=(newValue)
		@duration = newValue * 60.0
	end

	def duration=(newValue)
		@duration = parse_duration(newValue)
	end

private
	def parse_duration(duration)
		if duration.is_a?(Integer)
			duration
		elsif duration.is_a?(String)
			if duration =~ /(\d+:)?(\d+:)?(\d+)$/
				total = 0
				cur_power = 1

				duration.split(/:/).reverse_each { |element|
					total += element.to_i * cur_power
					cur_power *= 60
				}

				total
			else
				nil
			end
		end	
	end
end

songs = [
	Song.new("Bicylops", "Fleck", 260)
]

any_song = songs.first

songs.each { |song|
	puts song.inspect
}

puts any_song.name 

any_song.name = "Test"

puts any_song.name

puts any_song.duration
puts any_song.durationInMinutes

any_song.durationInMinutes = 2.0
puts any_song.duration

class Playlist
	include Enumerable
	extend Forwardable

	def_delegators :@songs, :each, :<<

	def initialize(songs)
		@songs = Array.new(songs)
	end

	def append(song)
		@songs.push(song)
		self
	end

	def total_duration()
		@songs.reduce(0) { |result, song| result + song.duration }
	end

	def [](key)
		if key.kind_of?(Integer)
			@songs[key]
		else
			@songs.find { |song| key == song.name }
		end
	end
end


madonna_album = Playlist.new([
	Song.new("Hung Up", "Madonna", "5:37"),
	Song.new("Get Together", "Madonna", "5:29"),
	Song.new("Sorry", "Madonna", "4:41"),
	Song.new("Future Lovers", "Madonna", "4:52"),
	Song.new("I Love New York", "Madonna", "4:11"),
	Song.new("Let It Will Be", "Madonna", "4:18"),
	Song.new("Forbidden Love", "Madonna", "4:22"),
	Song.new("Jump", "Madonna", "3:46"),
	Song.new("How High", "Madonna", "4:40"),
	Song.new("Isaac", "Madonna", "6:03"),
	Song.new("Push", "Madonna", "3:57"),
	Song.new("Like It or Not", "Madonna", "4:32")
])

puts "Total duration #{madonna_album.total_duration}" 
puts "Total duration of 'Sorry': #{madonna_album["Sorry"].duration}"
