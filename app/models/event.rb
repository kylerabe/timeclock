class Event < ActiveRecord::Base
  belongs_to :person

  validates_presence_of  :time, :person_id
  validates_inclusion_of :action, :in => [true, false]

  default_scope :order => 'time ASC'

  named_scope :pay_period_with_offset, lambda {|n|
    today = DateTime.now
    if today.day <= 15 && n % 2 == 0
      start_date = DateTime.new(today.year, today.month, 1) << n/2
      end_date   = DateTime.new(today.year, today.month, 16) << n/2
    elsif today.day > 15 && n % 2 == 0
      start_date = DateTime.new(today.year, today.month, 16) << n/2
      end_date   = DateTime.new(today.year, today.month, 1) >> 1 << n/2
    elsif today.day <= 15 && n % 2 == 1
      start_date = DateTime.new(today.year, today.month, 16) << (n/2 + 1)
      end_date   = DateTime.new(today.year, today.month, 1) << n/2
    elsif today.day > 15 && n % 2 == 1
      start_date = DateTime.new(today.year, today.month, 1) << n/2
      end_date   = DateTime.new(today.year, today.month, 16) << n/2
    end
    start_date = start_date - Time.now.gmt_offset.seconds
    end_date = end_date - Time.now.gmt_offset.seconds
    {:conditions => ["time BETWEEN ? AND ?", start_date, end_date]}
  }

  def action_name
    self.action == true ? 'In' : 'Out'
  end

  def local_time
    self.time.getlocal.strftime("%a %b %d %Y, %I:%M %p")
  end
end

class Array
  def newest
    (self.sort {|x, y| y.time <=> x.time}).first
  end
end

class Float
  def seconds_to_hours(precision)
    ((self/3600) * 10 ** precision).round.to_f / 10 ** precision
  end
end

# class Float
#   def to_hms
#     [(self/3600) % 60,
#      (self/60)   % 60,
#      (self)      % 60].map{|t| t.to_i.to_s.rjust(2, '0')}.join(':')
#   end
# end
