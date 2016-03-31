class GildedRose
  attr_reader :name, :days_remaining, :quality, :item

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
    @item = klass_for(name).new(days_remaining: days_remaining, quality: quality)
  end

  def klass_for(name)
    return Normal if @name.include?("Normal")
    return Brie if @name.include?("Aged Brie")
    return Sulfuras if @name.include?("Sulfuras, Hand of Ragnaros")
    return Backstage if @name.include?("Backstage")
  end

  def tick
    update_attributes(item.tick)
  end

  def update_attributes(item)
    @days_remaining = item.days_remaining
    @quality = item.quality
  end
end

class Item
  attr_reader :days_remaining, :quality

  def initialize(days_remaining:, quality:)
    @days_remaining = days_remaining
    @quality = quality
  end
end

class Normal < Item
  def tick
    @days_remaining -= 1
    return self if @quality == 0

    @quality -= 1
    @quality -= 1 if @days_remaining <= 0
    return self
  end
end

class Brie < Item
  def tick
    @days_remaining -= 1
    return self if @quality == 50

    @quality += 1
    @quality += 1 if @days_remaining <= 0 && @quality < 50
    return self
  end
end

class Backstage < Item
  def tick
    @days_remaining -= 1
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
