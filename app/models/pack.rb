class Pack < ApplicationRecord
  belongs_to :packable, polymorphic: true

  def price
    if packable.kind_of? ItemMaster
      (count || 1) * packable.price.to_f
    else
      0
    end
  end

  validate :uniqueness_of_count

  def uniqueness_of_count
    if Pack.where(packable: packable, count: count).any?
      errors.add(:count, 'Already exist')
    end
  end

end
