class Tire < ActiveRecord::Base
  validates_uniqueness_of [:width_mm, :profile, :rim_inches]
  validates_numericality_of :width_mm
  validates_numericality_of :rim_inches
  validates_numericality_of :profile
  before_save :store_dimensions

  def self.search(search_params)
    search = self.all
    table = self.arel_table
    if search_params
      match_params = {}
      gt_params = {}
      lt_params = {}
      conditions = []
      search_params.each do |key , value|
        if key =~ /^gt_(.+)$/
          gt_params[$1] = value unless value.empty?
        elsif key =~ /^lt_(.+)$/
          lt_params[$1] = value unless value.empty? 
        else
          match_params[key] = value unless value.empty? 
        end
      end
      gt_params.each do |key, value|
        conditions << table[key].gt(value)
      end

      lt_params.each do |key, value|
        conditions << table[key].lt(value)
      end

      match_params.each do |key , value|
        conditions << table[key].eq(value)
      end
      where_clause = table[:rim_inches].eq(table[:rim_inches])

      conditions.each do | condition|
       where_clause = where_clause.and(condition) 
      end
      search = search.where(where_clause)
    end

    search.order(:height_mm => :desc)
  end

  def store_dimensions
    self.sidewall_mm = sidewall_height * 25.4
    self.height_mm = height * 25.4
  end

  def spec
    "#{width_mm}/#{profile}-#{rim_inches}"
  end
  def height
    sidewall_height * 2 + rim_inches 
  end
  def sidewall_height
    (width_mm*(profile/100.0))/25.4
  end
  def self.create_with(tires_input)
    @created_tires = []
    @parse_errors  = []
    tires_input.split(" ").each do |tire_input|
      begin
        @created_tires << self.create_tire!(tire_input)
      rescue Exception => e
        @parse_errors << {:input => tire_input, :error_message => e.message}
      end
    end
    return @created_tires, @parse_errors
  end
  def self.create_tire!(tire_input)
    first = tire_input.split("/")
    width = first.first
    rim   = first.last.split("-").last
    profile   = first.last.split("-").first
    tire =  Tire.create!(:width_mm => width, :rim_inches => rim, :profile => profile)
  end
end
