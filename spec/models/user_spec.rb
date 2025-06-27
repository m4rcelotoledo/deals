# frozen_string_literal: true

require 'rails_helper'

describe User do
  it { is_expected.to have_many(:deals).dependent(:destroy) }
end
