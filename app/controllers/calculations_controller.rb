class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    array_of_words = @text.split
    @word_count = array_of_words.count

    @character_count_with_spaces = @text.length

    text_wo_spaces = @text.gsub(" ","")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")

    @character_count_without_spaces = text_wo_tabs.length

    # Count number of words within the @special_word field
    # step 1: convert @text from a string, to an array of words (with split)
    # step 2: count number of words within new array_of_user_words
    # step 3: count number of times @special word appears in array_of_user_words

    # array_of_user_words = @text.split
    # array_of_user_words.count => 7
    # array_of_user_words.count(takes an object as an argument)
    # @special_word is an object
    #
    # step 4: try giving .count, the argument of @special_word; what does it return?
    # use puts to print out result

text_without_period = @text.gsub(".", "")
text_without_comma = text_without_period.gsub(",", "")
text_without_exclamation = text_without_comma.gsub("!", "")
text_without_colon = text_without_exclamation.gsub(":", "")
text_without_semicolon = text_without_colon.gsub(",", "")
text_without_question_mark = text_without_semicolon.gsub("?", "")
text_with_forward_slash = text_without_question_mark.gsub("/", "")
text_without_back_slash = text_with_forward_slash.gsub("\\", "")

downcase_text= text_without_back_slash.downcase
array_of_user_words = downcase_text.split

    @occurrences = array_of_user_words.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    rate = @apr / 100 / 12
    nper = @years * 12

    @monthly_payment = (rate * @principal) / (1- (1+ rate)**-nper)


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median =

    if @count.odd?
      @median = @sorted_numbers[@count / 2]
    else
      left_of_middle = @sorted_numbers[(@count / 2) - 1]
      right_of_middle = @sorted_numbers[(@count / 2)]
      @median = (left_of_middle + right_of_middle) / 2
    end


    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    squared_differences = []

    @numbers.each do |num|
      difference = num - @mean
      squared_difference = difference ** 2
      squared_differences.push(squared_difference)
    end

    @variance = squared_differences.sum / @count

    @standard_deviation = Math.sqrt(@variance)

    leader = nil
    leader_count = 0

    @numbers.each do |num|
      occurrences = @numbers.count(num)
      if occurrences > leader_count
        leader = num
        leader_count = occurrences
      end
    end



    @mode = leader

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
