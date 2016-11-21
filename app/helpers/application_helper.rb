module ApplicationHelper

  def error_class(resource, *fields)
    fields.any?{ |f| resource.errors[f].any? } ? 'has-error' : ''
  end

  def classification_options
    Space.classifications.keys.map { |c| [c.humanize, c] }
  end

  def city_options
    City.active.includes(:state).reduce({}) do |h, city|
      h[city.state.name] ||= []
      h[city.state.name] << [city.name, city.id]
      h
    end
  end

  def capacity_options
    [
      ['< 50', :less_50],
      ['50-100', :between_50_100],
      ['100-200', :between_100_200],
      ['200-500', :between_200_500],
      ['500-1000', :between_500_1000],
      ['> 1000', :more_1000]
    ]
  end

  def hours_options
    date = DateTime.current.beginning_of_day
    (0..23).map{ |h| [date.change(hour: h).strftime('%l:00 %p'), h] }
  end

  def category_options
    Category.active.map { |c| [c.name, c.id] }
  end
end
