# frozen_string_literal: true

module DealsHelper
  def status_badge_color(status)
    case status
    when 'open'
      'primary'
    when 'won'
      'success'
    when 'lost'
      'danger'
    else
      'secondary'
    end
  end
end
