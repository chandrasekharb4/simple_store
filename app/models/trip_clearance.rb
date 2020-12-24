class TripClearance <  ActiveRecord::Base

	def self.date_scope(departure_date)
    if departure_date.blank?
      scoped
    else
      where("departure_date=?", departure_date.to_date)
    end
  end

end
