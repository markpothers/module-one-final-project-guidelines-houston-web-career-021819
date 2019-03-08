class Service < ActiveRecord::Base

  has_many :deals
  has_many :merchants, through: :deals
  has_many :cities, through: :deals

  def self.service_types
    Service.all.map do |service|
      service.service
    end
  end

end