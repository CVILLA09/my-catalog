require 'rspec'
require_relative '../classes/item'

describe Item do
  let(:today) { Date.today }
  let(:ten_years_ago) { today.prev_year(10) }
  let(:item) { Item.new(ten_years_ago.to_s) }

  describe '#can_be_archived?' do
    it 'returns false if published date is not older than 10 years' do
      recent_item = Item.new(today.to_s)
      expect(recent_item.can_be_archived?).to be_falsey
    end
  end

  describe '#move_to_archive' do
    it 'does not archive the item if it cannot be archived' do
      recent_item = Item.new(today.to_s)
      recent_item.move_to_archive
      expect(recent_item.archived).to be_falsey
    end
  end
end
