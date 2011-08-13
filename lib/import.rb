require 'csv'

class Import
  def initialize source
    @source = source
  end

  def each
    ignoring_first_line = true
    @source.each do |line|
      if ignoring_first_line
        ignoring_first_line = false
        next
      end
      yield parse_story line
    end
  end

  def parse_story line
    row = CSV.parse_line line
    attributes = {}
    attributes[:title] = row[0]
    attributes[:estimate] = row[2]
    attributes[:started] = row[3]
    attributes[:finished] = row[4]
    attributes[:hours_worked] = row[5]
    Story.new attributes
  end
end
