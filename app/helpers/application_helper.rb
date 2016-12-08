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

  def available_city_options
    City.available.includes(:state).reduce({}) do |h, city|
      h[city.state.name] ||= []
      h[city.state.name] << [city.name, city.id]
      h
    end
  end

  def capacity_options
    Space.capacities.keys.map{ |c| [capacity_humanized(c), c] }
  end

  def hours_options
    date = DateTime.current.beginning_of_day
    (0..23).map{ |h| [date.change(hour: h).strftime('%l:00 %p'), h] }
  end

  def category_options
    Category.active.map { |c| [c.name, c.id] }
  end

  def capacity_humanized(capacity)
    {
      less_50: '< 50',
      between_50_100: '50-100',
      between_100_200: '100-200',
      between_200_500: '200-500',
      between_500_1000: '500-1000',
      more_1000: '> 1000'
    }[capacity.to_sym]
  end

  def panel_class_for_rating(rating)
    case rating
      when 0..2 then 'panel-danger'
      when 3    then 'panel-default'
      when 4..5 then 'panel-success'
      else           'panel-default'
    end
  end

  def date_format
    '%m/%d/%y'
  end
end
