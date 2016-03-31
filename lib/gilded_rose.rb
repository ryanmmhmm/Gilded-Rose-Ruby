class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def update_attributes(item)
    @days_remaining = item.days_remaining
    @quality = item.quality
  end

  def normal_tick
    item = Normal.new(days_remaining: @days_remaining, quality: @quality)
    update_attributes(item.tick)
  end

  def brie_tick
    item = Brie.new(days_remaining: @days_remaining, quality: @quality)
    update_attributes(item.tick)
  end

  def sulfuras_tick
  end

  def backstage_tick
    @days_remaining -= 1
    return if @quality >= 50
    return @quality = 0 if @days_remaining < 0

    @quality += 1
    @quality += 1 if @days_remaining < 10
    @quality += 1 if @days_remaining < 5
  end

  def tick
    return normal_tick if @name.include?("Normal")
    return brie_tick if @name.include?("Aged Brie")
    return sulfuras_tick if @name.include?("Sulfuras, Hand of Ragnaros")
    return backstage_tick if @name.include?("Backstage")
  end
end

class Normal
  attr_reader :days_remaining, :quality

  def initialize(days_remaining:, quality:)
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    @days_remaining -= 1
    return self if @quality == 0

    @quality -= 1
    @quality -= 1 if @days_remaining <= 0
    return self
  end
end

class Brie
  attr_reader :days_remaining, :quality

  def initialize(days_remaining:, quality:)
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    @days_remaining -= 1
    return self if @quality == 50

    @quality += 1
    @quality += 1 if @days_remaining <= 0 && @quality < 50
    return self
  end
end
