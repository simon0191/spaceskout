class Spaces::SearchService

  PRICE_RANGE_REGEX = /(?<min>\d+),(?<max>\d+)/

  def self.attrs
    @attrs ||= [:classification, :city_id, :ratings, :price_hourly_range, :categories, :amenities, :availabilities]
  end

  def self.permitted_params
    @permitted_params ||= [:classification, :city_id, :price_hourly_range, categories: [], amenities: [], availabilities: [], ratings: []]
  end

  attr_accessor *attrs

  def initialize(opts={})
    opts.each do |k, v|
      if self.class.attrs.include?(k.to_sym)
        self.send("#{k}=", v)
      end
    end
  end

  def search(spaces=Space.all)
    spaces = spaces.where(classification: classification) if classification.present?
    spaces = spaces.where(city_id: city_id) if city_id.present?
    spaces = filter_by_ratings(spaces, ratings) if ratings.present? && ratings.any?
    spaces = spaces.where(':min <= price_hourly AND price_hourly <= :max', min: price_hourly_min, max: price_hourly_max) if price_hourly_range.present?
    spaces = filter_by_categories(spaces, categories) if categories.present?
    spaces = filter_by_amenities(spaces, amenities) if amenities.present? && amenities.any?
    spaces = filter_by_availabilities(spaces, availabilities) if availabilities.present? && availabilities.any?
    spaces
  end

  def formatted_price_hourly_range
    [price_hourly_min, price_hourly_max] if price_hourly_range.present?
  end

  private

    def price_hourly_min
      @price_hour_min ||= price_hourly_range.match(PRICE_RANGE_REGEX)[:min].to_i
    end

    def price_hourly_max
      @price_hour_max ||= price_hourly_range.match(PRICE_RANGE_REGEX)[:max].to_i
    end


    def filter_by_amenities(spaces, amenities)
      filter_by_boolean_columns(spaces, amenities.map(&:to_sym) & Space.amenities)
    end

    def filter_by_availabilities(spaces, availabilities)
      filter_by_boolean_columns(spaces, availabilities.map(&:to_sym) & Space.days)
    end

    def filter_by_boolean_columns(spaces, cols)
      cols.each do |col|
        spaces = spaces.where("#{col} = ?", true)
      end
      spaces
    end

    def filter_by_ratings(spaces, ratings)
      query = ratings.map { |r| '(spaces.rating >= ? AND spaces.rating < ?)' }.join(' OR ')
      vars = ratings.map(&:to_i).reduce([]) { |arr, x| arr.push(x, x+1) }
      spaces.where(query, *vars)
    end

    def filter_by_categories(spaces, categories)
      if categories.reject(&:blank?).any?
        spaces.joins(:space_categories).where('space_categories.category_id': categories.reject(&:blank?))
      else
        spaces
      end
    end
end