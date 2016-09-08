require 'pry'

class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize (content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency()
  end

  def calculate_word_frequency
    words_count = Hash.new(0)
    @content.split.each {|w| words_count[w.downcase] += 1}

    @highest_wf_count = words_count.max_by {|k, v| v}[1]

    @highest_wf_words = words_count.select {|k,v| v == @highest_wf_count }.map {|k, v| k}
  end

end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file
    File.foreach('test.txt').with_index do |line, line_number|
      @analyzers.push(LineAnalyzer.new(line, line_number))
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = @analyzers.map {|a| a.highest_wf_count}.max
    @highest_count_words_across_lines = @analyzers
      .select {|a| a.highest_wf_count == @highest_count_across_lines}
  end

  def print_highest_word_frequency_across_lines
  end
end
