class TeaFacade
  def self.tea_db_flood
    TeaService.get_all_teas.each do |tea|
      data = {
        title: tea[:name],
        description: tea[:description],
        temperature: tea[:temperature],
        brew_time: tea[:brew_time]
      }
      TeaType.create(data)
    end
  end
end