# frozen_string_literal: true

require 'rails_helper'

describe Deal do
  subject(:deal) { described_class.new }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:customer) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:closing_date_probability) }
  it { is_expected.to validate_presence_of(:value) }

  it 'has a valid enum status' do
    expect(deal).to define_enum_for(:status).with_values(%i[pending won lost])
  end
end
