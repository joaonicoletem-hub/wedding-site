class AddCompanionsAndDietaryRestrictionsToRsvps < ActiveRecord::Migration[8.1]
  def change
    add_column :rsvps, :companion_names, :text
    add_column :rsvps, :dietary_restrictions, :text
  end
end
