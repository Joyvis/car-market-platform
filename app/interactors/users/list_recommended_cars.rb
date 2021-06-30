module Users
  class ListRecommendedCars
    def self.call(user:, car_brand_name: nil, price_min: nil, price_max: nil)
      json = File.read(Rails.root.join('public', 'response.json'))
      JSON.parse(json, symbolize_names: true)
    end
  end
end
