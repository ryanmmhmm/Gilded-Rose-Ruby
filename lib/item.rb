class Item
  attr_reader :days_remaining, :quality

  def initialize(days_remaining:, quality:)
    @days_remaining = days_remaining
    @quality = quality
  end

  def decrease_days_remaining
    @days_remaining -= 1
  end
end

class Normal < Item
  def tick
    decrease_days_remaining
    return self if @quality == 0

    @quality -= 1
    @quality -= 1 if @days_remaining <= 0
    return self
  end
end

class Brie < Item
  def tick
    decrease_days_remaining
    return self if @quality == 50

    @quality += 1
    @quality += 1 if @days_remaining <= 0 && @quality < 50
    return self
  end
end

class Backstage < Item
  def tick
    decrease_days_remaining
    return self if @quality >= 50

    if @days_remaining < 0
      @quality = 0
      return self
    end

    @quality += 1
    @quality += 1 if @days_remaining < 10
    @quality += 1 if @days_remaining < 5
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
    @quality -= 1 if @quality >= 1
    @quality -= 1 if @quality >= 1

    if @days_remaining <= 0
      @quality -= 1 if @quality >= 1
      @quality -= 1 if @quality >= 1
    end
    return self
  end
end
