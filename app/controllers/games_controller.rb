require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    @attempt = params[:word]
    @letters = params[:letters]
    if included?
      if english_word?
        @score = "Congratulations! #{@attempt} is a valid English word!"
      else
        @score = "Sorry but #{@attempt} does not seem to be an English word..."
      end
    else
      @score = "Sorry but #{@attempt} can't be build out of #{@letters}"
    end
  end

  def included?
    @attempt.chars.all? { |letter| @attempt.count(letter) <= @letters.count(letter) }
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    response = URI.parse(url)
    json = JSON.parse(response.read)
    # response = URI.open(url).read
    # json = JSON.parse(response)
    json['found']
  end
end
