require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("a"..."z").to_a.sample(10)
  end

  def score
    @user_input = params[:user_input]
    @return = is_english_word?(@user_input)
    return_answer(@return)
  end

  def return_answer(check)
    if (check)
      @answer = "Congratulations! #{@user_input} is a valid English word"
    elsif (!check)
      @answer = "Sorry but #{@user_input} does not seem to be a valid English word..."
    else
      @answer = "Sorry but #{@user_input} can't be built out of #{@letters}"
    end
  end

  private

  def is_english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_check = JSON.parse(open(url).read)
    @result = word_check["found"]
  end
end
