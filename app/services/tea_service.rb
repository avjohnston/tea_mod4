class TeaService
  def self.get_all_teas
    response = Faraday.get('https://tea-api-vic-lo.herokuapp.com/tea')
    JSON.parse(response.body, symbolize_names: true)
  end
end