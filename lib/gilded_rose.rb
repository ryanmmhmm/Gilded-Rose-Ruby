require 'item'

class GildedRose
  attr_reader :name, :days_remaining, :quality, :item

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
    @item = klass_for(name).new(days_remaining: days_remaining, quality: quality)
  end

  def tick
    update_attributes(item.tick)
  end

  private

  def klass_for(name)
    case name
    when /Normal/
      return Normal
    when /Brie/
      return Brie
    when /Sulfuras/
      return Sulfuras
    when /Backstage/
      return Backstage
    when /Conjured/
      return Conjured
    end
  end

  def update_attributes(item)
    @days_remaining = item.days_remaining
    @quality = item.quality
  end
end
