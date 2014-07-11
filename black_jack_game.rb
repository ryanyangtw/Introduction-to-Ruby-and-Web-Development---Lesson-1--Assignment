require "pry"


def initialize_poker
	decks_of_poker = []

	4.times do
  decks_of_poker << {:spades=>{'A'=>11, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8, '9'=>9, '10'=>10, 'J'=>10, 'Q'=>10, 'K'=>10}, :hearts=>{'A'=>11, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8, '9'=>9, '10'=>10, 'J'=>10, 'Q'=>10, 'K'=>10}, :diamonds=>{'A'=>11, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8, '9'=>9, '10'=>10, 'J'=>10, 'Q'=>10, 'K'=>10}, :clubs=>{'A'=>11, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8, '9'=>9, '10'=>10, 'J'=>10, 'Q'=>10, 'K'=>10}}
	end

	return decks_of_poker
end

def initialize_deal_card(decks_of_poker,player,computer)
	deal_card(decks_of_poker,player)
	deal_card(decks_of_poker,computer)
	deal_card(decks_of_poker,player)
	deal_card(decks_of_poker,computer)
end

def deal_card(decks_of_poker, someone)

		poker = random_deck_of_poker(decks_of_poker)
		random_suit = poker.keys.sample
		random_card = poker[random_suit].keys.sample

		hash = {:suit=>randam_suit, :card=>random_card, :value=>poker[randam_suit][random_card]}		
		someone[:cards].push(hash)
		poker[randam_suit].delete(random_card)
		
end


def random_deck_of_poker(decks_of_poker)
	selected_deck = [0,1,2,3].sample
	return decks_of_poker[selected_deck]
end

def calculate_sum(someone)
	sum = 0
	someone[:cards].each do |val|
		sum = sum + val[:value] 
	end
	return sum
end

def check_ace_exist?(someone)
	someone[:cards].each do |val|
		if(val[:value] == 11)
			val[:value] = 1
			return true
		end
	end

	return false
end


def check_blackjack_or_busted(someone)
		
		sum = calculate_sum(someone)

		if(sum == 21)
			print_cards(someone)
			puts "#{someone[:name]} get Blackjack!!"
			return 'blackjack'

		elsif(sum>21)
			if(check_ace_exist?(someone))
				return 
			else
				print_cards(someone)
				puts "#{someone[:name]} Busted!!"
				return 'busted'
			end
		else
			return 
		end
end


def print_cards(someone)

	someone[:cards].each do |val|
		puts "#{val[:suit]} #{val[:card]}"
	end
	puts "sum is #{calculate_sum(someone)}"
	puts "---------------------------"
end



def player_turn(decks_of_poker,player,computer)
	
	while((situation = check_blackjack_or_busted(player)) == nil)
		
		puts "Hey #{player[:name]}, you have cards include:"
		print_cards(player)
		puts "#{player[:name]}, please enter 'hit' or 'stay'"
		input = gets.chomp
		if(input == "stay")
			return 
		elsif(input == "hit")
			deal_card(decks_of_poker, player)
		else
			"You enter the wrong words!"
		end
			
	end

	if(situation == 'blackjack')
		return player
	elsif(situation == 'busted')
		return computer
	else
		return
	end

end

def computer_turn(decks_of_poker,player,computer)
	
	puts "***************************"
	puts "It's computer's turn: "
	while((situation = check_blackjack_or_busted(computer)) == nil)
		if(calculate_sum(computer)>=17)
			print_cards(computer)
			break
		end
		
		print_cards(computer)
		deal_card(decks_of_poker, computer)
	end

	if(situation == 'blackjack')
		return computer
	elsif(situation == 'busted')
		return player
	else
		return
	end

end

def compare_sum(player,computer)

	computer_sum  = calculate_sum(computer)
	player_sum = calculate_sum(player)

	if(computer_sum > player_sum)
		return computer
	elsif(computer_sum < player_sum)
		return player
	else
		return
	end

end


decks_of_poker = initialize_poker()
player = {}
computer = {:name=>"Computer"}
puts "Welcome to the blackjack game. What's your name?"
player[:name] = gets.chomp 

begin
	system("clear")
	player[:cards] = []
	computer[:cards] = []
	initialize_deal_card(decks_of_poker,player,computer)
	winner = player_turn(decks_of_poker,player,computer)
	
	if(winner == nil)
		winner = computer_turn(decks_of_poker,player,computer)
		if(winner == nil)
			winner = compare_sum(player, computer)
		end
	end

	puts "***************************"
	if(winner != nil)
		puts "winner is #{winner[:name]}"
	else
		puts "It's a tie!"
	end

	puts "Do you want to continue the game? Please enter 'yes' or 'no' "

end while((input = gets.chomp)=='yes')

puts "OK, BYE!"





