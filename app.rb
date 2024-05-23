require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  # @first_url = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
  # @first_response = HTTP.get(@first_url)
  # @first_string = @first_response.to_s
  # @first_data = JSON.parse(@first_string)

  # @second_url = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
  # @second_response = HTTP.get(@second_url)
  # @second_string = @second_response.to_s
  # @second_data = JSON.parse(@second_string)

  @first = {"success"=>true, "deck_id"=>"asf3s3wnp8cl", "remaining"=>52, "shuffled"=>true}
  @second = {"success"=>true, "deck_id"=>"z3nflaai4q7w", "remaining"=>52, "shuffled"=>true}
  
  erb(:home)
end

get("/play") do
  @card_first_url = "https://deckofcardsapi.com/api/deck/asf3s3wnp8cl/draw/?count=1"
  @card_first_response = HTTP.get(@card_first_url)
  @card_first_string = @card_first_response.to_s
  @card_first_data = JSON.parse(@card_first_string)
  @img_first = @card_first_data["cards"][0]["image"]
  @value_first = @card_first_data["cards"][0]["value"]

  @card_second_url = "https://deckofcardsapi.com/api/deck/z3nflaai4q7w/draw/?count=1"
  @card_second_response = HTTP.get(@card_second_url)
  @card_second_string = @card_second_response.to_s
  @card_second_data = JSON.parse(@card_second_string)
  @img_second = @card_second_data["cards"][0]["image"]
  @value_second = @card_second_data["cards"][0]["value"]

  #@true_value_second = 0

  if @value_second == "JACK"
    @true_value_second = 11
  elsif @value_second == "QUEEN"
    @true_value_second = 12
  elsif @value_second == "KING"
    @true_value_second = 13
  elsif @value_second == "ACE"
    @true_value_second = 14
  else
    @true_value_second = @value_second.to_i
  end

  if @value_first == "JACK"
    @true_value_first = 11
  elsif @value_first == "QUEEN"
    @true_value_first = 12
  elsif @value_first == "KING"
    @true_value_first = 13
  elsif @value_first == "ACE"
    @true_value_first = 14
  else
    @true_value_first = @value_first.to_i
  end
  
  if @true_value_second > @true_value_first
    @outcome = "You lost this battle!"
  elsif @true_value_second == @true_value_first
    @outcome = "You tied this battle!"
  elsif @true_value_second < @true_value_first
    @outcome = "You won this battle!"
  end

  @remaining_second = @card_second_data["remaining"]
  @remaining_first = @card_first_data["remaining"]
  
  erb(:play)
end

get("/shuffle") do
  @shuffle_first = "https://deckofcardsapi.com/api/deck/asf3s3wnp8cl/shuffle/"
  @shuffle_second = "https://deckofcardsapi.com/api/deck/z3nflaai4q7w/shuffle/"
  @first_response = HTTP.get(@shuffle_first)
  @second_response = HTTP.get(@shuffle_second)

  erb(:shuffle)
end
