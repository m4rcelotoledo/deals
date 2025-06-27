# frozen_string_literal: true

require 'rails_helper'

describe DealsHelper do
  describe '#status_badge_color' do
    it 'returns primary color for pending deals' do
      expect(helper.status_badge_color('open')).to eq 'primary'
    end

    it 'returns success color for won deals' do
      expect(helper.status_badge_color('won')).to eq 'success'
    end

    it 'returns warning color for lost deals' do
      expect(helper.status_badge_color('lost')).to eq 'danger'
    end

    it 'returns secondary color for other deals' do
      expect(helper.status_badge_color('other')).to eq 'secondary'
    end
  end
end
