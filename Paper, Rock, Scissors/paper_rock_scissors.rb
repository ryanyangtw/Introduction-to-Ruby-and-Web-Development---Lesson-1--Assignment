require 'pry'




def  who_won?(p_select, c_select)
	
	h = {"P"=>"Paper", "R"=>"Rock", "S"=>"Scissors"}
	puts "you picked #{h[p_select]} and computer picked #{h[c_select]}. "
	
	case p_select 
		when 'P'
			if c_select == 'R'
				puts 'You won!'
			elsif c_select == 'S'
				puts 'Computer won!'
			else
				puts "It's a tie"
			end
		when 'R'
			if c_select == 'S'
				puts 'You won!'
			elsif c_select == 'P'
				puts 'Computer won!'
			else
				puts "It's a tie"
			end
		when 'S'
			if c_select == 'P'
				puts 'You won!'
			elsif c_select == 'R'
				puts 'Computer won!'
			else
				puts "It's a tie"
			end
	end
	play_again?
end

def play_again?
	
	while true
		puts 'Player again? (Y/N)'
		response = gets.chomp
		response.upcase!

		if !['Y', 'N'].include?(response)
			puts "Error: you must enter Y or N"
			next
		end

		if response == "Y"
			puts "---- Starting a new Game ----"
			run
		else
			puts "OK, Bye!"
			exit
		end

	end

end


def run

	puts 'Play Ppaer Rock Scissors!'
	
	begin
		puts 'Choose one: (P/R/S)'
		response = gets.chomp
		response.upcase!
	end while !['P','R','S'].include?(response)


	who_won?(response, ['P', 'R', 'S'].sample)

end


run

