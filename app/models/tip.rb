class Tip < ActiveRecord::Base
  def Tip.search(query)
    entry = order("created_at")
    if query.present?
      entry = entry.where("tags LIKE ? OR title LIKE ?", "%#{query}%", "%#{query}%")
    end

    return entry
  end
end
