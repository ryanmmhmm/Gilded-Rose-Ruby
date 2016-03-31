class Item
  attr_reader :days_remaining, :quality
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(days_remaining:, quality:)
    @days_remaining = days_remaining
    @quality = quality
  end

  def decrease_days_remaining
    @days_remaining -= 1
  end

  def decrease_quality
    @quality -= 1
  end

  def increase_quality
    @quality += 1
  end
end

class Normal < Item
  def tick
    decrease_days_remaining
    return self if @quality == MIN_QUALITY

    decrease_quality
    decrease_quality if @days_remaining <= 0
    return self
  end
end

class Brie < Item
  def tick
    decrease_days_remaining
    return self if @quality == MAX_QUALITY

    increase_quality
    increase_quality if @days_remaining <= 0 && @quality < MAX_QUALITY
    return self
  end
end

class Backstage < Item
  def tick
    decrease_days_remaining
    return self if @quality >= MAX_QUALITY

    if @days_remaining < 0
      @quality = 0
      return self
    end

    increase_quality
    increase_quality if @days_remaining < 10
    increase_quality if @days_remaining < 5
    return self
  end
end

class Sulfuras < Item
  def tick
    return self
  end
end

class Conjured < Item
  def tick
    decrease_days_remaining
    decrease_quality if @quality > MIN_QUALITY
    decrease_quality if @quality > MIN_QUALITY

    if @days_remaining <= 0
      decrease_quality if @quality > MIN_QUALITY
      decrease_quality if @quality > MIN_QUALITY
    end
    return self
  end
end
