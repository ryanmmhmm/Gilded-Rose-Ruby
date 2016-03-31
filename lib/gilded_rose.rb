require 'item'

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
    return Conjured if @name.include?("Conjured")
  end

  def tick
    update_attributes(item.tick)
  end

  def update_attributes(item)
    @days_remaining = item.days_remaining
    @quality = item.quality
  end
end
